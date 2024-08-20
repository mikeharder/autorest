import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RestorePoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Properties of disk restore point
 */
@parentResource(RestorePoint)
model DiskRestorePoint
  is Azure.ResourceManager.ProxyResource<DiskRestorePointProperties> {
  ...ResourceNameParameter<
    Resource = DiskRestorePoint,
    KeyName = "diskRestorePointName",
    SegmentName = "diskRestorePoints",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DiskRestorePoints {
  /**
   * Get disk restorePoint resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiskRestorePoint_Get")
  get is ArmResourceRead<
    DiskRestorePoint,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<DiskRestorePoint>;

      /**
       * The name of the restore point collection that the disk restore point belongs.
       */
      @path
      restorePointCollectionName: string;
    }
  >;

  /**
   * Lists diskRestorePoints under a vmRestorePoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiskRestorePoint_ListByRestorePoint")
  listByRestorePoint is ArmResourceListByParent<
    DiskRestorePoint,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<DiskRestorePoint>;

      /**
       * The name of the restore point collection that the disk restore point belongs.
       */
      @path
      restorePointCollectionName: string;
    }
  >;

  /**
   * Grants access to a diskRestorePoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiskRestorePoint_GrantAccess")
  grantAccess is ArmResourceActionAsync<
    DiskRestorePoint,
    GrantAccessData,
    AccessUri,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<DiskRestorePoint>;

      /**
       * The name of the restore point collection that the disk restore point belongs.
       */
      @path
      restorePointCollectionName: string;
    }
  >;

  /**
   * Revokes access to a diskRestorePoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiskRestorePoint_RevokeAccess")
  revokeAccess is ArmResourceActionAsync<
    DiskRestorePoint,
    void,
    void,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<DiskRestorePoint>;

      /**
       * The name of the restore point collection that the disk restore point belongs.
       */
      @path
      restorePointCollectionName: string;
    }
  >;
}

@@doc(DiskRestorePoint.name, "The name of the disk restore point created.");
@@doc(DiskRestorePoint.properties,
  "Properties of an incremental disk restore point"
);
@@encodedName(DiskRestorePoints.grantAccess::parameters.body,
  "application/json",
  "grantAccessData"
);
@@extension(DiskRestorePoints.grantAccess::parameters.body,
  "x-ms-client-name",
  "grantAccessData"
);
@@doc(DiskRestorePoints.grantAccess::parameters.body,
  "Access data object supplied in the body of the get disk access operation."
);