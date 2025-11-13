from PIL import Image
from pyzbar.pyzbar import decode, ZBarSymbol
import requests
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/decode")
def get_book(isbn: str):
    url = f"https://www.googleapis.com/books/v1/volumes?q=isbn:{isbn}"
    response = requests.get(url)
    if response.status_code != 200:
        return {"error": "Book not found"}
    data = response.json()
    if "items" not in data or not data["items"]:
        return {"error": "Book not found"}
    
    book_info = data["items"][0]["volumeInfo"]
    return {
        "title": book_info.get("title", "No title available"),
        "authors": book_info.get("authors", ["No authors available"]),
        "publisher": book_info.get("publisher", "No publisher available"),
        "publishedDate": book_info.get("publishedDate", "No published date available"),
        "description": book_info.get("description", "No description available"),
        "pageCount": book_info.get("pageCount", "No page count available"),
        "categories": book_info.get("categories", ["No categories available"]),
        "thumbnail": book_info.get("imageLinks", {}).get("thumbnail", ""),
    }
