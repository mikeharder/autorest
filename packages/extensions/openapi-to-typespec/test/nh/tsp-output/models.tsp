import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace NotificationHubsClient;

union MSApiVersionType {
  string,
  `2015-01`: "2015-01",
  `2015-04`: "2015-04",
  `2015-08`: "2015-08",
  `2016-07`: "2016-07",
}

union NotificationHubContentModelType {
  string,
  `application/xml`: "application/xml",
}

union NotificationHubDescriptionModelXmlnsI {
  string,
  `http://www.w3.org/2001/XMLSchema-instance`: "http://www.w3.org/2001/XMLSchema-instance",
}

union NotificationHubDescriptionModelAuthorizationRulesItemIType {
  string,
  `http://www.w3.org/2001/XMLSchema-instance`: "http://www.w3.org/2001/XMLSchema-instance",
}

union NotificationHubDescriptionModelAuthorizationRulesItemClaimType {
  string,
  SharedAccessAuthorizationRule: "SharedAccessAuthorizationRule",
}

union RegistrationEntryModelXmlnsM {
  string,
  `http://schemas.microsoft.com/ado/2007/08/dataservices/metadata`: "http://schemas.microsoft.com/ado/2007/08/dataservices/metadata",
}

/**
 * PNS Platform for the installation
 */
union PlatformType {
  string,
  apns: "apns",
  wns: "wns",
  gcm: "gcm",
  baidu: "baidu",
  adm: "adm",
}

union InstallationPatchType {
  string,
  add: "add",
  remove: "remove",
  replace: "replace",
}

union FormatParameterType {
  string,
  apple: "apple",
  baidu: "baidu",
  gcm: "gcm",
  windows: "windows",
}

union RegistrationContentModelType {
  string,
  `application/xml`: "application/xml",
}

union AppleRegistrationContentModelXmlnsI {
  string,
  `http://www.w3.org/2001/XMLSchema-instance`: "http://www.w3.org/2001/XMLSchema-instance",
}

union AppleTemplateRegistrationContentModelXmlnsI {
  string,
  `http://www.w3.org/2001/XMLSchema-instance`: "http://www.w3.org/2001/XMLSchema-instance",
}

union BaiduRegistrationContentModelXmlnsI {
  string,
  `http://www.w3.org/2001/XMLSchema-instance`: "http://www.w3.org/2001/XMLSchema-instance",
}

union BaiduTemplateRegistrationContentModelXmlnsI {
  string,
  `http://www.w3.org/2001/XMLSchema-instance`: "http://www.w3.org/2001/XMLSchema-instance",
}

union GcmRegistrationContentModelXmlnsI {
  string,
  `http://www.w3.org/2001/XMLSchema-instance`: "http://www.w3.org/2001/XMLSchema-instance",
}

union GcmTemplateRegistrationContentModelXmlnsI {
  string,
  `http://www.w3.org/2001/XMLSchema-instance`: "http://www.w3.org/2001/XMLSchema-instance",
}

union WindowsRegistrationContentModelXmlnsI {
  string,
  `http://www.w3.org/2001/XMLSchema-instance`: "http://www.w3.org/2001/XMLSchema-instance",
}

union WindowsTemplateRegistrationContentModelXmlnsI {
  string,
  `http://www.w3.org/2001/XMLSchema-instance`: "http://www.w3.org/2001/XMLSchema-instance",
}

union ApiVersionType {
  string,
  `2015-01`: "2015-01",
  `2015-04`: "2015-04",
  `2015-08`: "2015-08",
  `2016-07`: "2016-07",
  `2020-06`: "2020-06",
}

/**
 * Content type for upload
 */
enum ContentType {
  /**
   * Content Type 'application/json;charset=utf-8'
   */
  `application/json;charset=utf-8`,

  /**
   * Content Type 'application/xml;charset=utf-8'
   */
  `application/xml;charset=utf-8`,
}

model NotificationHubEntryModel {
  content?: NotificationHubContentModel;
}

model NotificationHubContentModel {
  type?: NotificationHubContentModelType;

  @encodedName("application/json", "NotificationHubDescription")
  notificationHubDescription?: NotificationHubDescriptionModel;
}

model NotificationHubDescriptionModel {
  @encodedName("application/json", "xmlns:i")
  xmlnsI?: NotificationHubDescriptionModelXmlnsI;

  @encodedName("application/json", "RegistrationTtl")
  registrationTtl?: string;

  @encodedName("application/json", "Location")
  location?: string;

  @encodedName("application/json", "ApnsCredential")
  apnsCredential?: PropertyBagModelItem[];

  @encodedName("application/json", "GcmCredential")
  gcmCredential?: PropertyBagModelItem[];

  @encodedName("application/json", "WnsCredential")
  wnsCredential?: PropertyBagModelItem[];

  @encodedName("application/json", "AuthorizationRules")
  authorizationRules?: NotificationHubDescriptionModelAuthorizationRulesItem[];
}

model PropertyBagModelItem {
  @encodedName("application/json", "Name")
  name?: string;

  @encodedName("application/json", "Value")
  value?: string;
}

model NotificationHubDescriptionModelAuthorizationRulesItem {
  @encodedName("application/json", "i:type")
  iType?: NotificationHubDescriptionModelAuthorizationRulesItemIType;

  @encodedName("application/json", "ClaimType")
  claimType?: NotificationHubDescriptionModelAuthorizationRulesItemClaimType;

  @encodedName("application/json", "ClaimValue")
  claimValue?: string;

  @encodedName("application/json", "Rights")
  rights?: string[];

  @encodedName("application/json", "CreatedTime")
  createdTime?: string;

  @encodedName("application/json", "ModifiedTime")
  modifiedTime?: string;

  @encodedName("application/json", "KeyName")
  keyName?: string;

  @encodedName("application/json", "PrimaryKey")
  primaryKey?: string;

  @encodedName("application/json", "SecondaryKey")
  secondaryKey?: string;
}

model RegistrationEntryModel {
  content?: NotificationHubContentModel;

  @encodedName("application/json", "xmlns:m")
  xmlnsM?: RegistrationEntryModelXmlnsM;

  @encodedName("application/json", "m:etag")
  mEtag?: string;
}

@resource("{hubName}/installations/{installationId}")
model InstallationModel {
  /**
   * Installation Unique Identifier
   */
  // FIXME: (resource-key-guessing) - Verify that this property is the resource key, if not please update the model with the right one
  @key
  installationId: string;

  /**
   * The user ID for the installation
   */
  userId?: string;

  /**
   * The date when the installation was made inactivate by the PNS.
   */
  @visibility("read")
  lastActiveOn?: string;

  /**
   * Date in W3C format of last update to this installation.
   */
  @visibility("read")
  lastUpdate?: string;

  /**
   * PNS Platform for the installation
   */
  platform: PlatformType;

  /**
   * The unique device handle for the PNS.
   */
  pushChannel: string;

  /**
   * This is true if the PNS expired the channel.
   */
  @visibility("read")
  expiredPushChannel?: boolean;

  /**
   * The tags for the installation for targeting
   */
  tags?: string[];

  /**
   * Set of named templates associated with the installation.
   */
  templates?: Record<InstallationTemplateModel>;

  /**
   * Set of secondary tiles associated with the installation. Applies only to the
   * 'wns' platform.
   */
  secondaryTiles?: Record<InstallationSecondaryTileModel>;
}

model InstallationTemplateModel {
  /**
   * Template for the body of the notification.
   */
  body: string;

  /**
   * Set of named headers associated with the template. Header values can contain
   * template parameters.
   */
  headers?: Record<string>;

  /**
   * Template expression evaluating in W3D date format.
   */
  expiry?: string;

  /**
   * The tags for the installation for targeting
   */
  tags?: string[];
}

model InstallationSecondaryTileModel {
  /**
   * ChannelUri for the secondary tile. Applies only to the 'wns' platform.
   */
  pushChannel: string;

  /**
   * The tags for the installation for targeting
   */
  tags?: string[];

  /**
   * Set of named templates associated with the secondary tile. Applies only to the
   * 'wns' platform.
   */
  templates?: Record<InstallationTemplateModel>;
}

model InstallationPatchModelItem {
  `op`: InstallationPatchType;
  path: string;
  value?: string;
}

model RegistrationContentModel {
  type?: RegistrationContentModelType;

  @encodedName("application/json", "AppleRegistrationDescription")
  appleRegistrationDescription?: AppleRegistrationContentModel;

  @encodedName("application/json", "AppleTemplateRegistrationDescription")
  appleTemplateRegistrationDescription?: AppleTemplateRegistrationContentModel;

  @encodedName("application/json", "BaiduRegistrationDescription")
  baiduRegistrationDescription?: BaiduRegistrationContentModel;

  @encodedName("application/json", "BaiduTemplateRegistrationDescription")
  baiduTemplateRegistrationDescription?: BaiduTemplateRegistrationContentModel;

  @encodedName("application/json", "GcmRegistrationDescription")
  gcmRegistrationDescription?: GcmRegistrationContentModel;

  @encodedName("application/json", "GcmTemplateRegistrationDescription")
  gcmTemplateRegistrationDescription?: GcmTemplateRegistrationContentModel;

  @encodedName("application/json", "WindowsRegistrationDescription")
  windowsRegistrationDescription?: WindowsRegistrationContentModel;

  @encodedName("application/json", "WindowsTemplateRegistrationDescription")
  windowsTemplateRegistrationDescription?: WindowsTemplateRegistrationContentModel;
}

model AppleRegistrationContentModel {
  @encodedName("application/json", "xmlns:i")
  xmlnsI?: AppleRegistrationContentModelXmlnsI;

  @encodedName("application/json", "Tags")
  tags?: string;

  @encodedName("application/json", "DeviceToken")
  deviceToken: string;
}

model AppleTemplateRegistrationContentModel {
  @encodedName("application/json", "xmlns:i")
  xmlnsI?: AppleTemplateRegistrationContentModelXmlnsI;

  @encodedName("application/json", "Tags")
  tags?: string;

  @encodedName("application/json", "DeviceToken")
  deviceToken: string;

  @encodedName("application/json", "BodyTemplate")
  bodyTemplate: string;

  @encodedName("application/json", "Expiry")
  expiry?: string;
}

model BaiduRegistrationContentModel {
  @encodedName("application/json", "xmlns:i")
  xmlnsI?: BaiduRegistrationContentModelXmlnsI;

  @encodedName("application/json", "Tags")
  tags?: string;

  @encodedName("application/json", "BaiduUserId")
  baiduUserId: string;

  @encodedName("application/json", "BaiduChannelId")
  baiduChannelId: string;
}

model BaiduTemplateRegistrationContentModel {
  @encodedName("application/json", "xmlns:i")
  xmlnsI?: BaiduTemplateRegistrationContentModelXmlnsI;

  @encodedName("application/json", "Tags")
  tags?: string;

  @encodedName("application/json", "BaiduUserId")
  baiduUserId: string;

  @encodedName("application/json", "BaiduChannelId")
  baiduChannelId: string;

  @encodedName("application/json", "BodyTemplate")
  bodyTemplate: string;
}

model GcmRegistrationContentModel {
  @encodedName("application/json", "xmlns:i")
  xmlnsI?: GcmRegistrationContentModelXmlnsI;

  @encodedName("application/json", "Tags")
  tags?: string;

  @encodedName("application/json", "GcmRegistrationId")
  gcmRegistrationId?: string;
}

model GcmTemplateRegistrationContentModel {
  @encodedName("application/json", "xmlns:i")
  xmlnsI?: GcmTemplateRegistrationContentModelXmlnsI;

  @encodedName("application/json", "Tags")
  tags?: string;

  @encodedName("application/json", "GcmRegistrationId")
  gcmRegistrationId: string;

  @encodedName("application/json", "BodyTemplate")
  bodyTemplate: string;
}

model WindowsRegistrationContentModel {
  @encodedName("application/json", "xmlns:i")
  xmlnsI?: WindowsRegistrationContentModelXmlnsI;

  @encodedName("application/json", "Tags")
  tags?: string;

  @encodedName("application/json", "ChannelUri")
  channelUri: string;
}

model WindowsTemplateRegistrationContentModel {
  @encodedName("application/json", "xmlns:i")
  xmlnsI?: WindowsTemplateRegistrationContentModelXmlnsI;

  @encodedName("application/json", "Tags")
  tags?: string;

  @encodedName("application/json", "ChannelUri")
  channelUri: string;

  @encodedName("application/json", "BodyTemplate")
  bodyTemplate: string;

  @encodedName("application/json", "WnsHeaders")
  wnsHeaders?: WindowsTemplateRegistrationContentModelWnsHeadersItem[];
}

model WindowsTemplateRegistrationContentModelWnsHeadersItem {
  @encodedName("application/json", "Header")
  header?: string;

  @encodedName("application/json", "Value")
  value?: string;
}
