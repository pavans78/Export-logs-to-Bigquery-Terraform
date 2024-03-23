resource "google_bigquery_dataset" "bigquery_dataset" {
  dataset_id                 = var.dataset_id
  description                = "contains the logs from the log explorer"
  project                    = var.project
  location                   = var.region
  delete_contents_on_destroy = false

  labels = {
    env = "test"
  }

}
