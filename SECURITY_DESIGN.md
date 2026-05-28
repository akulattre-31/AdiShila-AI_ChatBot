# ENTERPRISE SECURITY ARCHITECTURE & THREAT MODEL

## 1. Security Architecture & Decisions
We are using a **3-Tier Architecture**:
1. **Presentation Tier (Frontend):** Strictly separated from the backend. Contains NO secrets, NO API keys, and NO direct external network calls.
2. **Application Tier (Backend - FastAPI):** The ONLY entity allowed to communicate with the Gemini LLM. Enforces Rate Limiting, Input Validation (Pydantic), and JWT Authentication.
3. **Data & ML Tier:** A decoupled Machine Learning engine that processes user interactions asynchronously to prevent API blocking.

## 2. Threat Model & Attack Surface Analysis
- **Vector 1: Key Extraction.** Mitigation: All API keys moved to backend `.env`.
- **Vector 2: Prompt Injection / Jailbreaking.** Mitigation: Backend prefixes and sanitizes all prompts. Input length is strictly validated.
- **Vector 3: Denial of Service (DoS/DDoS) & Rate Limit Abuse.** Mitigation: IP-based rate limiting implemented at the API Gateway/Backend level.
- **Vector 4: Data Poisoning (ML).** Mitigation: ML pipeline strictly sanitizes text and removes PII before saving to the training corpus.

## 3. Secret Management
- Strict use of `.env` files.
- `GEMINI_API_KEY` and `JWT_SECRET` are never committed to version control.
- In production, these should heavily rely on Azure Key Vault or AWS Secrets Manager.

## 4. AI Security Protections
- **Backend-Only AI Calls:** The frontend sends a user message to `/api/chat`. The backend constructs the final payload.
- **Sanitized Outputs:** The backend uses regex to strip any potentially malicious script tags before sending the LLM output back to the frontend.

## 5. Machine Learning Integration
- **Sanitization:** Analyzes user intent, strips names/emails, and converts raw text to embeddings.
- **Recommendation Engine:** Stores historical buying intents to dynamically alter the system prompt, offering tailored Shungite products.
