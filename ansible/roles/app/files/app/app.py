import asyncpg
from fastapi import FastAPI
import uvicorn
from pydantic import BaseModel
from typing import List

DATABASE_URL = "postgresql://cytech_usr:cytech@192.168.100.133/cytech"

app = FastAPI()

class Cytech(BaseModel):
    id: int
    name: str

pool = None

@app.on_event("startup")
async def startup():
    global pool
    pool = await asyncpg.create_pool(DATABASE_URL)

@app.on_event("shutdown")
async def shutdown():
    global pool
    if pool:
        await pool.close()

async def get_all_cytech_data() -> List[Cytech]:
    async with pool.acquire() as connection:
        rows = await connection.fetch("SELECT id, name FROM cytech")
        return [Cytech(id=row['id'], name=row['name']) for row in rows]

@app.get("/", response_model=List[Cytech])
async def read_cytech_data():
    return await get_all_cytech_data()


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8080)