/**
 * PLEASE DO NOT REMOVE - USED FOR CONVERTER METRICS
 * Generated by package: @autorest/openapi-to-typespec
 * Parameters used:
 *   isFullCompatible: false
 *   guessResourceKey: true
 * Version: Not generated in test
 * Date: Not generated in test
 */
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

/**
 * A client for issuing REST requests to the Azure Batch service.
 */
@useAuth(
  AadOauth2Auth<["user_impersonation"]> | ApiKeyAuth<
    ApiKeyLocation.header,
    "Authorization"
  >
)
@service(#{ title: "Azure Batch Service" })
@versioned(Versions)
@server(
  "{batchUrl}",
  "A client for issuing REST requests to the Azure Batch service.",
  {
    batchUrl: string,
  }
)
namespace Azure.Batch;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-01-01.15.0 API version.
   */
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_01_01_15_0: "2022-01-01.15.0",
}
