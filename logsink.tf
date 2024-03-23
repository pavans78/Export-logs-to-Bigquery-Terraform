
resource "google_logging_project_sink" "bq-sink" {
  name                   = var.logsink_name
  destination            = "bigquery.googleapis.com/projects/${var.project}/datasets/${var.dataset_id}"
  filter                 = "logName=\"projects/firm-shuttle-413014/logs/cloudaudit.googleapis.com%2Factivity\" resource.type=k8s_cluster resource.labels.location=us-central1-c resource.labels.cluster_name=prod-cluster"
  unique_writer_identity = true

  exclusions {
    name        = "nonproduction"
    description = "Exclude logs from non-production clusters"
    filter      = "logName=\"projects/firm-shuttle-413014/logs/cloudaudit.googleapis.com%2Factivity\" resource.type=k8s_cluster resource.labels.location=us-central1-c resource.labels.cluster_name!=prod-cluster"
  }

  bigquery_options {
    use_partitioned_tables = true # always true if it is false, logs cant export to the bigquery
  }

  depends_on = [
    google_bigquery_dataset.bigquery_dataset
  ]

}


data "google_project" "project" {

}


resource "google_project_iam_binding" "log-writer" {
  project = var.project
  role    = "roles/bigquery.dataEditor"

  members = [
    google_logging_project_sink.bq-sink.writer_identity
  ]
  depends_on = [
    google_logging_project_sink.bq-sink
  ]
}


