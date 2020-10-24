from fastapi import FastAPI, HTTPException, Depends
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import JWTError
from passlib.hash import pbkdf2_sha256
from starlette import status

from src.db_orm import *
from src.security_utils import *
from src.server_data_model import *

tags_metadata = [
    {
        "name": "token",
        "description": "Generate Token you can use username: ketul and password:ketul",
    },
    {
        "name": "listChemicals",
        "description": "Get all chemical elements,This endpoint should return a list of all chemical elements with "
                       "their names and ids. ",
    },
    {
        "name": "get_commodity",
        "description": "Get a comodity by id,This endpoint returns one commodity by id. A commodity chemical "
                       "composition shouldcontain id and name of the elements. ",
    },
    {
        "name": "update_commodity",
        "description": "Update commodity by id. This endpoint should update commodity name, price and inventory by "
                       "its id. If a field is not provided, it should not be updated. IMP EX: ONLY "
                       "commodity_id is compulsory and one one from the rest can be updated"
                       "{\"commodity_id\":5,\"inventory\":54 ,  \"name\": \"hello2\","
                       "\"price\": 5.2,}",
    },
    {
        "name": "add_chemical_to_commodity",
        "description": "takes a commodity id, element id and a percentage and adds it to the commodity "
                       "chemical composition. ",
    },
    {
        "name": "remove_chemical_from_commodity",
        "description": " removes an element from the chemical composition by id ",
    },
]

app = FastAPI(title="SMS Test Project",
              description="This Project  provides apis",
              openapi_tags=tags_metadata)

oauth_schema = OAuth2PasswordBearer(tokenUrl="token")


@app.get("/")
async def home():
    return "{hello:'greetings'}"


@app.post("/token", tags=["token"])
async def authenticate(data: OAuth2PasswordRequestForm = Depends()):
    user = UserDetails.from_orm(get_user_by_id(data.username))
    if pbkdf2_sha256.verify(data.password, user.password):
        access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
        access_token = create_access_token(
            data={"sub": user.username}, expires_delta=access_token_expires
        )
        return {"access_token": access_token, "token_type": "bearer"}
    else:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password.",
            headers={"WWW-Authenticate": "Bearer"},
        )


def validate(token: str = Depends(oauth_schema)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception
    user = UserDetails.from_orm(get_user_by_id(username))
    if user is None:
        raise credentials_exception
    return "valid"


@app.get("/listChemicals", tags=["listChemicals"])
async def list_chemicals(token: str = Depends(validate)):
    chemicals = get_all_chemicals()
    serverObjs = []
    for i in chemicals:
        serverObjs.append(Chemical.from_orm(i))
    return serverObjs


@app.get("/commodity/{id}", tags=["get_commodity"])
async def get_commodity(id: int, token: str = Depends(validate)):
    # return get_composition_by_id(id)
    return Commodity.from_orm(get_composition_by_id(id))


@app.post("/updateCommodity", tags=["update_commodity"])
async def update_commodity(item: dict, token: str = Depends(validate)):
    if "commodity_id" in item.keys():
        results = await  update_commodity_in_db(item);
        return results
    else:
        raise HTTPException(
            status_code=404,
            detail="Please provide commodity_id",
            headers={"X-Error": "commodity_key not provided"},
        )


@app.post("/addChemicalToCommodity", tags=["add_chemical_to_commodity"])
async def add_chemical_to_commodity(item: InsertChemicalComposition, token: str = Depends(validate)):
    return await add_chemical_to_commodity_in_db(item.dict())


@app.post("/removeChemicalFromCommodity", tags=["remove_chemical_from_commodity"])
async def remove_chemical_from_commodity(item: RemoveChemicalComposition, token: str = Depends(validate)):
    return await remove_chemical_from_commodity_in_db(item.dict())
