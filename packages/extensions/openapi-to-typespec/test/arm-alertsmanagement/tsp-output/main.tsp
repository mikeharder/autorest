/**
 * PLEASE DO NOT REMOVE - USED FOR CONVERTER METRICS
 * Generated by package: @autorest/openapi-to-typespec
 * Parameters used:
 *   isFullCompatible: true
 *   guessResourceKey: true
 * Version: Not generated in test
 * Date: Not generated in test
 */
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./back-compatible.tsp";
import "./AlertProcessingRule.tsp";
import "./Alert.tsp";
import "./SmartGroup.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * AlertsManagement Client
 */
@armProviderNamespace
@service(#{ title: "AlertsManagementClient" })
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now. Set to v3.
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Azure.ResourceManager.AlertsManagement;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2021-08-08 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_08_08: "2021-08-08",

  /**
   * The 2019-05-05-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2019_05_05_preview: "2019-05-05-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
