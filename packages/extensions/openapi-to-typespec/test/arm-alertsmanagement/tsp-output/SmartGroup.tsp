import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.ResourceManager.AlertsManagement;
/**
 * Set of related alerts grouped together smartly by AMS.
 */
@subscriptionResource
model SmartGroup is Azure.ResourceManager.ProxyResource<SmartGroupProperties> {
  ...ResourceNameParameter<
    Resource = SmartGroup,
    KeyName = "smartGroupId",
    SegmentName = "smartGroups",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SmartGroups {
  /**
   * Get information related to a specific Smart Group.
   */
  getById is ArmResourceRead<
    SmartGroup,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List all the Smart Groups within a specified subscription.
   */
  getAll is ArmResourceListByParent<
    SmartGroup,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * Filter by target resource( which is full ARM ID) Default value is select all.
       */
      @query("targetResource")
      targetResource?: string;

      /**
       * Filter by target resource group name. Default value is select all.
       */
      @query("targetResourceGroup")
      targetResourceGroup?: string;

      /**
       * Filter by target resource type. Default value is select all.
       */
      @query("targetResourceType")
      targetResourceType?: string;

      /**
       * Filter by monitor service which generates the alert instance. Default value is select all.
       */
      @query("monitorService")
      monitorService?: MonitorService;

      /**
       * Filter by monitor condition which is either 'Fired' or 'Resolved'. Default value is to select all.
       */
      @query("monitorCondition")
      monitorCondition?: MonitorCondition;

      /**
       * Filter by severity.  Default value is select all.
       */
      @query("severity")
      severity?: Severity;

      /**
       * Filter by state of the smart group. Default value is to select all.
       */
      @query("smartGroupState")
      smartGroupState?: AlertState;

      /**
       * Filter by time range by below listed values. Default value is 1 day.
       */
      @query("timeRange")
      timeRange?: TimeRange;

      /**
       * Determines number of alerts returned per page in response. Permissible value is between 1 to 250. When the "includeContent"  filter is selected, maximum value allowed is 25. Default value is 25.
       */
      @query("pageCount")
      pageCount?: int64;

      /**
       * Sort the query results by input field. Default value is sort by 'lastModifiedDateTime'.
       */
      @query("sortBy")
      sortBy?: SmartGroupsSortByFields;

      /**
       * Sort the query results order in either ascending or descending.  Default value is 'desc' for time fields and 'asc' for others.
       */
      @query("sortOrder")
      sortOrder?: SortOrder;
    },
    Response = ArmResponse<SmartGroupsList>
  >;

  /**
   * Change the state of a Smart Group.
   */
  changeState is ArmResourceActionSync<
    SmartGroup,
    void,
    ArmResponse<SmartGroup>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * New state of the alert.
       */
      @query("newState")
      newState: AlertState;
    }
  >;

  /**
   * Get the history a smart group, which captures any Smart Group state changes (New/Acknowledged/Closed) .
   */
  @get
  @action("history")
  getHistory is ArmResourceActionSync<
    SmartGroup,
    void,
    ArmResponse<SmartGroupModification>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-format"
@@format(SmartGroup.name, "uuid");
@@doc(SmartGroup.name, "Smart group unique id. ");
@@doc(SmartGroup.properties, "Properties of smart group.");
