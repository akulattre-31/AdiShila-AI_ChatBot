# AdiShilaChatBot


AdiShila AI TaskPilot is an enterprise-grade AI chatbot application powered by Google's **Gemini 2.5 Flash** model. It features a responsive web frontend and a robust Python FastAPI backend, designed for low-latency streaming and persistent memory.

## 🚀 Key Features
- **Real-Time Streaming Responses**: Utilizes Server-Sent Events (SSE) to stream Gemini's responses character-by-character, providing a premium, ultra-fast user experience.
- **Enterprise-Grade Backend**: Built on **FastAPI** to handle concurrent requests efficiently and securely.
- **Persistent Cloud Memory**: Integrated with a **Neon Serverless Postgres Database** via `psycopg2`, ensuring that all chat histories are permanently stored and securely retrieved, surviving across server deployments.
- **Security Protocols**: Implements strict security measures including PII redaction pipelines and secure API Key isolation from the frontend.

## 🛠️ Tech Stack
- **Frontend**: Vanilla HTML/JS/CSS (Optimized for Netlify deployment).
- **Backend**: Python (FastAPI, Uvicorn, HTTPX).
- **Database**: PostgreSQL (Neon Serverless).
- **AI Model**: Google Gemini 2.5 Flash.
- **Deployment**: Render (Backend API) & Netlify (Frontend).

## 💻 Local Setup
1. Clone the repository.
2. Navigate to the `backend` folder and install dependencies:
   ```bash
   cd backend
   pip install -r requirements.txt
   ```
3. Create a local `.env` file in the `backend` folder containing:
   ```env
   GEMINI_API_KEY=your_gemini_api_key
   DATABASE_URL=your_neon_postgres_url
   ```
4. Start the backend server:
   ```bash
   uvicorn main:app --reload
   ```
5. Open `index.html` in your browser (preferably via Live Server) to interact with the chatbot locally!
