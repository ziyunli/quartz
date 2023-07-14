---
title: "Learning Google Analytics"
date: 2023-07-12
tags: 
- Book
---

Target audience: digital marketers with digital analytics background


## Raw Notes
### Chapter 1

- What's GA 4
- Why is it developed?
	- Simpler data model: event-only
		- automatically collection that are pre-configured
		- better flexibility to define your own metrics
	- Different data sources: specifically mobile
		- Leveraging Firebase SDK
	- Machine learning
	- Privacy
		- Consent mode
		- without consent, GA still can collect non-personal data
- GCP integrations
	- Firebase
	- BigQuery
	- ...

Basic event example:

```json
{
	"client_id": "...",
	"events": {
		"name": "...",
		"params": { ... },
	},
	"user_properties": { ...}
}
```

### Chapter 2

