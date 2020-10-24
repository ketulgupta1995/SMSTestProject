from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import *

Base = declarative_base()
engine = None
is_connected = False


def create_connection():
    global engine, is_connected
    while not is_connected:
        try:
            engine = create_engine("mysql+mysqlconnector://root:root@db:3306/test1")
            is_connected = true
        except:
            print("Trying to connect again!")


create_connection()


class ChemicalORM(Base):
    __tablename__ = "chemicals"
    chem_id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String(50), nullable=False)


class CommodityORM(Base):
    __tablename__ = "commodities"
    commodity_id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String(50), nullable=False)
    price = Column(Float)
    inventory = Column(Float)
    chemical_composition = relationship('ChemicalCompositionORM', lazy="joined")


class ChemicalCompositionORM(Base):
    __tablename__ = "chemical_composition"
    chem_id = Column(Integer, ForeignKey("chemicals.chem_id"), primary_key=True)
    commodity_id = Column(Integer, ForeignKey("commodities.commodity_id"), primary_key=True)
    percentage = Column(Float, nullable=False)
    chemical_details = relationship("ChemicalORM", lazy="joined")


class UserORM(Base):
    __tablename__ = "user_pass"
    username = Column(String, primary_key=True)
    password = Column(String)


def getSession():
    return sessionmaker(bind=engine)


def populate_Chemicals():
    session = getSession()()
    chemicals = []
    for i in range(0, 50):
        chemicals.append(ChemicalORM(chem_id=i, name="Chem No" + str(i)))
    session.add_all(chemicals)
    session.commit()


def populate_commodities():
    session = getSession()()
    commodities = []
    for i in range(0, 50):
        commodities.append(CommodityORM(commodity_id=i, name="Commodity No " + str(i)))
    session.add_all(commodities)
    session.commit()


def get_all_chemicals():
    session = getSession()()
    return session.query(ChemicalORM).all()


async def update_commodity_in_db(item: dict):
    session = getSession()()
    session.query(CommodityORM).filter(CommodityORM.commodity_id == item.pop("commodity_id")).update(item)
    session.commit()
    return "success"


def get_composition_by_id(id: int):
    session = getSession()()
    return session.query(CommodityORM).filter(CommodityORM.commodity_id == id).first()


async def add_chemical_to_commodity_in_db(param):
    count, session = await get_chemical_count(param)
    print(count)
    # not present  add
    if count == 0:
        session.add(ChemicalCompositionORM(commodity_id=param["commodity_id"], chem_id=param["chem_id"],
                                           percentage=param["percentage"]))
        session.commit()
    else:
        session.query(ChemicalCompositionORM). \
            filter(ChemicalCompositionORM.commodity_id == param["commodity_id"]) \
            .filter(ChemicalCompositionORM.chem_id == param["chem_id"]) \
            .update({"percentage": param['percentage']})
        session.commit()

    await update_unknow_element(param, session)
    session.commit()
    return "success"


async def update_unknow_element(param, session):
    unknown_present = await is_unknown_present(param, session)
    total = await get_total_percentage_without_unknown(param, session)
    if total < 100 and unknown_present == 1:
        session.query(ChemicalCompositionORM). \
            filter(ChemicalCompositionORM.commodity_id == param["commodity_id"]) \
            .filter(ChemicalCompositionORM.chem_id == 999) \
            .update({"percentage": 100 - total})
    elif total < 100 and unknown_present == 0:
        session.add(ChemicalCompositionORM(commodity_id=param["commodity_id"], chem_id=999,
                                           percentage=100 - total))
    elif total == 100:
        await delete_unknown(param, session)


async def delete_unknown(param, session):
    count = session.query(ChemicalCompositionORM) \
        .filter(ChemicalCompositionORM.commodity_id == param["commodity_id"]) \
        .filter(ChemicalCompositionORM.chem_id == 999) \
        .count()
    print(count)
    if count != 0:
        obj = session.query(ChemicalCompositionORM). \
            filter(ChemicalCompositionORM.commodity_id == param["commodity_id"]) \
            .filter(ChemicalCompositionORM.chem_id == 999) \
            .first()
        session.delete(obj)
    session.commit()


async def is_unknown_present(param, session):
    return session.query(ChemicalCompositionORM). \
        filter(ChemicalCompositionORM.commodity_id == param["commodity_id"]) \
        .filter(ChemicalCompositionORM.chem_id == 999) \
        .count()


async def get_total_percentage_without_unknown(param, session):
    # all chem except Unknown
    chemicals = session.query(ChemicalCompositionORM). \
        filter(ChemicalCompositionORM.commodity_id == param["commodity_id"]) \
        .filter(ChemicalCompositionORM.chem_id != 999) \
        .all()
    total = 0
    for i in chemicals:
        total += i.percentage
    return total


async def get_chemical_count(param):
    session = getSession()()
    count = session.query(ChemicalCompositionORM) \
        .filter(ChemicalCompositionORM.commodity_id == param["commodity_id"]) \
        .filter(ChemicalCompositionORM.chem_id == param["chem_id"]) \
        .count()
    return count, session


async def remove_chemical_from_commodity_in_db(param: dict):
    session = getSession()()
    count = session.query(ChemicalCompositionORM) \
        .filter(ChemicalCompositionORM.commodity_id == param["commodity_id"]) \
        .filter(ChemicalCompositionORM.chem_id == param["chem_id"]) \
        .count()
    print(count)
    if count == 0:
        return "this element is not present in given commodity"
    else:
        obj = session.query(ChemicalCompositionORM). \
            filter(ChemicalCompositionORM.commodity_id == param["commodity_id"]) \
            .filter(ChemicalCompositionORM.chem_id == param["chem_id"]) \
            .first()
        session.delete(obj)
        await update_unknow_element(param, session)
    session.commit()
    return True


def get_user_by_id(username: str):
    session = getSession()()
    return session.query(UserORM).filter(UserORM.username == username).first()

# populate_Chemicals()
# populate_commodities()
