import psycopg2
import psycopg2.extras
import json
import os

DATABASE_URL = os.getenv("DATABASE_URL", "")

def get_connection():
    return psycopg2.connect(DATABASE_URL)

def init_db():
    if not DATABASE_URL:
        print("DATABASE_URL not set. Skipping DB init.")
        return
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS chat_history (
            id SERIAL PRIMARY KEY,
            session_token TEXT NOT NULL,
            role TEXT NOT NULL,
            message TEXT NOT NULL,
            timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ''')
    conn.commit()
    cursor.close()
    conn.close()

def save_message(session_token: str, role: str, message: str):
    if not DATABASE_URL:
        return
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute('''
        INSERT INTO chat_history (session_token, role, message)
        VALUES (%s, %s, %s)
    ''', (session_token, role, message))
    conn.commit()
    cursor.close()
    conn.close()

def get_chat_history(session_token: str):
    if not DATABASE_URL:
        return []
    conn = get_connection()
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cursor.execute('''
        SELECT role, message FROM chat_history
        WHERE session_token = %s
        ORDER BY timestamp ASC
    ''', (session_token,))
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    
    history = []
    for row in rows:
        history.append({
            "role": row['role'],
            "parts": [{"text": row['message']}]
        })
    return history
