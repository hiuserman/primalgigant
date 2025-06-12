from fastapi import APIRouter
from app.service.book_service import get_book_info

router = APIRouter()

@router.get("/decode")

def decode(isbn: str):
    return get_book_info(isbn)