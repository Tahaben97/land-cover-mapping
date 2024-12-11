.PHONY: clean_data processed_data upload_clean upload_preprocessed clean help
# Variables
BUCKET_NAME=land-cover-mapping-lewagon1831

# Dossiers locaux
LOCAL_CLEAN_PATH=data/clean_data
LOCAL_PROCESSED_PATH=data/processed_data

# Dossiers distants sur le bucket
REMOTE_CLEAN_PATH=clean_data
REMOTE_PROCESSED_PATH=processed_data


CLEAN_DATA_PATH=clean_data/         # Chemin des données nettoyées dans le bucket
PROCESSED_DATA_PATH=processed_data/ # Chemin des données traitées dans le bucket
CLEAN_LOCAL_DIR=data/
PROCESSED_LOCAL_DIR=data/


# Règle pour uploader les données propres (clean)
upload_clean:
	gcloud storage cp -r $(LOCAL_CLEAN_PATH) gs://$(BUCKET_NAME)/$(REMOTE_CLEAN_PATH)

# Règle pour uploader les données traitées (processed)
upload_preprocessed:
	gcloud storage cp -r $(LOCAL_PROCESSED_PATH) gs://$(BUCKET_NAME)/$(REMOTE_PROCESSED_PATH)

# Nettoyage local (optionnel)
clean:
	rm -rf $(LOCAL_CLEAN_PATH)
	rm -rf $(LOCAL_PROCESSED_PATH)

# Afficher de l'aide
help:
	@echo "Available commands:"
	@echo "  make upload_clean    - Upload $(LOCAL_CLEAN_PATH) to GCS bucket $(BUCKET_NAME)/$(REMOTE_CLEAN_PATH)"
	@echo "  make upload_preprocessed - Upload $(LOCAL_PROCESSED_PATH) to GCS bucket $(BUCKET_NAME)/$(REMOTE_PROCESSED_PATH)"
	@echo "  make clean           - Delete the local $(LOCAL_CLEAN_PATH) and $(LOCAL_PROCESSED_PATH) directories"


clean_data: ## Télécharge les données nettoyées depuis le bucket
	@mkdir -p $(CLEAN_LOCAL_DIR)
	$(GCS_COPY) gs://$(BUCKET_NAME)/$(CLEAN_DATA_PATH)* $(CLEAN_LOCAL_DIR)



processed_data: ## Télécharge les données traitées depuis le bucket
	@mkdir -p $(PROCESSED_LOCAL_DIR)
	gcloud storage cp -r gs://$(BUCKET_NAME)/$(PROCESSED_DATA_PATH)/ $(PROCESSED_LOCAL_DIR)
