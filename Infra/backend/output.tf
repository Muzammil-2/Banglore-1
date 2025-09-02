output "gcs_bucket_name" {
  value       = google_storage_bucket.terraform_state.name
  description = "The name of the GCS bucket used for Terraform state"
}

# Firestore locking is optional – only if you enable it
# Firestore always has a fixed name '(default)', so usually you just output info
output "firestore_database_name" {
  value       = google_firestore_database.terraform_locks.name
  description = "The Firestore database used for Terraform state locking"
}
