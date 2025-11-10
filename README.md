# README

# Chat System API

A Rails API-only application for a chat system.  
It allows creating applications, chats, and messages with asynchronous processing and full-text search using Elasticsearch.

---

# Quick Start
- Build and start all services:
  ```bash
  docker-compose up

# Configuration
- Ruby version: 3.2.x
- Rails version: 8.1.0
- database, Redis, and Elasticsearch configured via Docker.
  
# Services
- MySQL: main database
- Redis: background jobs & caching
- Sidekiq: asynchronous processing for chats & messages
- Elasticsearch: full-text search for messages

# Enhancements & Future Improvements
- Move docker-compose.yml to a separate repository for infrastructure-as-code.
- Add environment-specific configurations (production, staging, development).
