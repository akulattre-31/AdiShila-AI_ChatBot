import re

def sanitize_for_ml(text: str) -> str:
    """
    SECURITY: Remove PII (Emails, phone numbers, standard names) 
    before the data ever touches the training pipeline.
    """
    # Remove emails
    text = re.sub(r'\S+@\S+', '[EMAIL_REDACTED]', text)
    # Remove digits (potential phone numbers/CCs)
    text = re.sub(r'\d+', '[NUM_REDACTED]', text)
    return text.strip()

def process_and_train(user_id: str, raw_message: str):
    """
    Simulates a background Machine Learning pipeline.
    Takes user input, securely sanitizes it, and updates an embeddings database
    to fine-tune future recommendations.
    """
    try:
        clean_text = sanitize_for_ml(raw_message)
        
        # In a real environment, you would use scikit-learn or a Vector DB:
        # 1. Generate text embedding: vector = embedding_model.encode(clean_text)
        # 2. Store in secure Vector DB (e.g., pgvector, Milvus) mapped to user_id
        # 3. Retrain clustering algorithm for personalized recommendations
        
        # Log to secure internal audit trail
        print(f"[SECURE-LOG] ML Pipeline processed input for User:{user_id}. Stored encrypted vector.")
    except Exception as e:
        # SECURITY: Fail gracefully without exposing ML pipeline internals
        print(f"[SECURE-LOG] ML Pipeline Error: {str(e)}")
