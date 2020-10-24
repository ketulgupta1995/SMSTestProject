from typing import Optional, List
from pydantic import BaseModel


class Chemical(BaseModel):
    chem_id: int
    name: str

    class Config:
        orm_mode = True


class InsertChemicalComposition(BaseModel):
    chem_id: int
    commodity_id: int
    percentage: float


class UserDetails(BaseModel):
    username: str
    password: str

    class Config:
        orm_mode = True


class RemoveChemicalComposition(BaseModel):
    chem_id: int
    commodity_id: int


class ChemicalComposition(BaseModel):
    # chem_id: int
    # commodity_id: int
    chemical_details: Chemical
    percentage: float

    class Config:
        orm_mode = True


class Commodity(BaseModel):
    commodity_id: int
    name: Optional[str]
    price: Optional[float] = 0
    inventory: Optional[float] = 0
    chemical_composition: Optional[List[ChemicalComposition]]

    class Config:
        orm_mode = True
