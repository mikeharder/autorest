import { getSession } from "../autorest-session";
import { generateServiceInformation } from "../generate/generate-service-information";
import { TypespecProgram } from "../interfaces";
import { getOptions } from "../options";
import { formatTypespecFile } from "../utils/format";
import { getArmResourcesMetadata } from "../utils/resource-discovery";
const packageInfo = require("../../package.json");

export async function emitMain(filePath: string, program: TypespecProgram): Promise<void> {
  const { isArm } = getOptions();
  const content = `${getHeaders()}\n${isArm ? getArmServiceInformation(program) : getServiceInformation(program)}`;
  const session = getSession();
  session.writeFile({ filename: filePath, content: await formatTypespecFile(content, filePath) });
}

function getHeaders() {
  const { isTest } = getOptions();
  return [
    `/**`,
    `* PLEASE DO NOT REMOVE - USED FOR CONVERTER METRICS`,
    `* Generated by package: ${packageInfo.name}`,
    `* Version: ${isTest ? "Not generated in test" : packageInfo.version}`,
    `* Date: ${isTest ? "Not generated in test" : new Date().toISOString()}`,
    `*/`,
  ].join("\n");
}

function getServiceInformation(program: TypespecProgram) {
  const imports = [
    `import "@typespec/rest";`,
    `import "@typespec/http";`,
    `import "./routes.tsp";`,
    ``,
    `using TypeSpec.Rest;`,
    `using TypeSpec.Http;`,
    `using TypeSpec.Versioning;`,
  ];
  const content = generateServiceInformation(program);

  return [...imports, content].join("\n");
}

function getArmServiceInformation(program: TypespecProgram) {
  const imports = [
    `import "@typespec/rest";`,
    `import "@typespec/versioning";`,
    `import "@azure-tools/typespec-azure-core";`,
    `import "@azure-tools/typespec-azure-resource-manager";`,
    `import "./models.tsp";`,
    ...getArmResourceImports(program),
    ``,
    `using TypeSpec.Rest;`,
    `using TypeSpec.Http;`,
    `using Azure.ResourceManager.Foundations;`,
    `using Azure.Core;`,
    `using Azure.ResourceManager;`,
    `using TypeSpec.Versioning;`,
  ];
  const content = generateServiceInformation(program);

  return [...imports, content].join("\n");
}

function getArmResourceImports(program: TypespecProgram): string[] {
  const resourceMetadata = getArmResourcesMetadata();
  const imports: string[] = [];

  for (const resource in resourceMetadata.Resources) {
    imports.push(`import "./${resourceMetadata.Resources[resource].SwaggerModelName}.tsp";`);
  }

  if (program.operationGroups.length > 0) {
    imports.push(`import "./routes.tsp";`);
  }

  return imports;
}
