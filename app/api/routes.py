from fastapi import APIRouter
from app.services.book_service import get_book_info

router = APIRouter()

@router.get("/decode")

def decode_book(isbn: str):
    return get_book_info(isbn)