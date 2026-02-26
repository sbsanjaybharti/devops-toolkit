from fastapi import FastAPI, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker, declarative_base, Session

# Database
DATABASE_URL = "sqlite:///database.db"
engine = create_engine(DATABASE_URL)
session = sessionmaker(bind=engine)
Base = declarative_base()
# Dependency
def get_db():
    db = session()
    try:
        yield db
    finally:
        db.close()

# Model
class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, autoincrement=True)
    username = Column(String, unique=True, nullable=False)
    email = Column(String, unique=True, nullable=False)

    def as_dict(self):
        return {
            "id": self.id,
            "username": self.username,
            "email": self.email
        }
Base.metadata.create_all(bind=engine)

# Schema
class UserSchema(BaseModel):
    username: str
    email: str


app = FastAPI()

@app.post("/users", response_model=UserSchema)
def create_user(user: UserSchema, db: Session = Depends(get_db)):
    try:
        new_user = User(username=user.username, email=user.email)
        db.add(new_user)
        db.commit()
        return new_user.as_dict()
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/users", response_model=list[UserSchema])
def get_users(db: Session = Depends(get_db)):
    return db.query(User).all()

@app.get("/user/{user_id}", response_model=UserSchema)
def get_user(user_id: int, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user.as_dict()

@app.put("/user/{user_id}", response_model=UserSchema)
def update_user(user_id: int, updated_user: UserSchema, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    user.username = updated_user.username
    user.email = updated_user.email
    db.commit()
    return user.as_dict()

@app.get("/")
def read_root():
    return {"Hello": "World"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)


