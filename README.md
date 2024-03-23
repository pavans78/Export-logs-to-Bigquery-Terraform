# Export-logs-to-Bigquery-Terraform

Terraform for log sink and exporting the logs to the BigQuery. A log sink in Google Cloud Platform (GCP) acts as a pipeline to channel logs from Cloud Logging to various destinations, including BigQuery. Here's how you can set up a log sink for exporting logs to BigQuery:

## Understanding Log Sinks:

A log entry is sent to the Google Cloud resource specified in its logName field during its entries.write call.

Cloud Logging receives log entries with the Cloud Logging API where they pass through the Log Router. The sinks in the Log Router check each log entry against the existing inclusion filter and exclusion filters that determine which destinations, including Big Query, that the log entry should be sent to. You can use combinations of sinks to route logs to multiple destinations.

Sinks control how Cloud Logging routes logs. Using sinks, you can route some or all of your logs to supported destinations(Big Query).

## More on Filters
When creating a log sink in Google Cloud Platform (GCP), you have the option to specify both inclusion and exclusion filters to precisely control which logs are routed to the sink's destination. Here's a bit more detail on how these filters work:

#### Inclusion Filters:

Inclusion filters are used to select specific logs that match certain criteria to be routed to the sink's destination.
You can configure inclusion filters based on various parameters such as log severity, resource labels, log entry fields, or custom metadata.
For example, you can create an inclusion filter to only export logs of a certain severity level (e.g., ERROR or CRITICAL), logs from specific resources (e.g., GKE Cluster), or logs containing specific keywords in the log message.


#### Exclusion Filters:

Exclusion filters, on the other hand, are used to exclude logs that match certain criteria from being routed to the sink's destination.
Exclusion filters are particularly useful for filtering out noisy or irrelevant logs, reducing unnecessary storage and processing costs.
Similar to inclusion filters, you can configure exclusion filters based on log severity, resource labels, log entry fields, or custom metadata.
For example, you can create an exclusion filter to exclude logs of a certain severity level (e.g., DEBUG or INFO), logs from specific resources that are known to be noisy, or logs containing sensitive information that shouldn't be exported.

## Usage Tips:

***Precise Filtering:***  Use a combination of inclusion and exclusion filters to precisely control which logs are exported to the sink's destination. This allows you to tailor the log export behavior to your specific requirements.
Regular Expression Support: Both inclusion and exclusion filters support regular expressions, providing flexibility in defining complex filtering criteria.

***Testing and Validation:***  Test your filters thoroughly to ensure that they select or exclude the desired logs accurately. You can use the Log Router's preview feature to validate filter configurations before applying them.

By leveraging inclusion and exclusion filters effectively, you can optimize the log export process, ensuring that only relevant logs are exported to the sink's destination while minimizing unnecessary noise and overhead. This helps streamline log analysis, monitoring, and troubleshooting workflows in your GCP environment.

## Additional Considerations:

* **BigQuery Dataset:**  Ensure the BigQuery dataset you choose (or create) has the appropriate permissions for the Cloud Logging service account to write data.

* **Table Structure:**  BigQuery tables created by log sinks follow a specific schema. 

* **Partitioning:**  You can configure log sinks to use either date-sharded tables (default) or partitioned tables for better manageability of log data in BigQuery.

## Try it out

1. Initialize your new Terraform configuration by running the terraform init command in the same directory as your main.tf file:

    ```sh
    terraform init
    ```

1. To validate and format the terraform code:
   ```sh
   terraform validate
   terraform fmt
   ```

1. See the execution plan by running the terraform plan command with var-file, var-file is the inputs of the variables:

    ```sh
    terraform plan -var-file=var.tfvars 
    ```
    The output has a + next to resources blocks(google_bigquery_dataset & google_bigquery_table) , meaning that Terraform will create these resources. Beneath that, it shows the attributes that will be set. When the value displayed is (known after apply), it means that the value won't be known until the resource is created.

    If anything in the plan seems incorrect or dangerous, it is shows the error messages.

1. Apply you configuration now by running the command terraform apply:

    ```sh
    terraform apply -var-file=_var.tfvars --auto-approve
    ```

1. Clean up after you’re done:

    ```sh
    terraform destroy -var-file=_var.tfvars --auto-approve
    ```

----

* For in-depth instructions and details, refer to the official documentation on Logs Routing: [link](https://cloud.google.com/logging/docs/routing/overview)

This is not an official project and does not come with maintenance guarantees.
