import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace AutoRestPagingTestService;

/**
 * The status of the request
 */
union OperationResultStatus {
  string,
  Succeeded: "Succeeded",
  Failed: "Failed",
  canceled: "canceled",
  Accepted: "Accepted",
  Creating: "Creating",
  Created: "Created",
  Updating: "Updating",
  Updated: "Updated",
  Deleting: "Deleting",
  Deleted: "Deleted",
  OK: "OK",
}

model ProductResultValue is Azure.Core.Page<Product>;

model Product {
  properties?: ProductProperties;
}

model ProductProperties {
  id?: int32;
  name?: string;
}

@pagedResult
model ProductResult {
  @items
  values?: Product[];

  @nextLink
  nextLink?: string;
}

@pagedResult
model OdataProductResult {
  @items
  values?: Product[];

  @nextLink
  `odata.nextLink`?: string;
}

@pagedResult
model ProductResultValueWithXMSClientName {
  @items
  values?: Product[];

  @nextLink
  nextLink?: string;
}

model OperationResult {
  /**
   * The status of the request
   */
  status?: OperationResultStatus;
}
