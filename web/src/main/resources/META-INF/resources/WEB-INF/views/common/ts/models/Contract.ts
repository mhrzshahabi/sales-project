///<reference path="../../../../../../../static/isomorphic/system/development/smartclient.d.ts"/>
class Unit {
    public  id: number;
}
class DataType {
    public  id: number;

}
class Contract {
    public id:number;

}

class Material {
    public id:number;
}

class ContractDetailTypeTemplate {
    public id:number;
}

class ContractDetailType {
    public id:number;

    public  code: string

    public  material: Material

    public  materialId: number

    public  titleFa: string

    public  titleEn: string

    public  contractDetailTypeParams: ContractDetailTypeParam[]

    public  contractDetailTypeTemplates: ContractDetailTypeTemplate[]


}
class ContractDetailTypeParam {
    public id:number;
}
class ContractDetail {
    public  id:number;

    public  content:string;

    public  contract:Contract;

    public  contractId:number;

    public  contractDetailType:ContractDetailType;

    public  contractDetailTypeId:number;

    public  contractDetailTemplate:string;

    public  contractDetailValues:ContractDetailValue[];

    public cdtpDynamicTableValue: { [key:string]:{cdtpId____:string,rowNum____:string,cdtpDtId____:string,[key:string]:string}[] };

    public  position:number;

}
class ContractDetailValue {
    public  id: number;

    public  name: string;

    public  key: string;

    public  title: string;

    public  type: DataType;

    public  reference: string;

    public  required: boolean;

    public  value: string;

    public  unit: Unit;

    public  unitId: number;

    public  contractDetail: ContractDetail;

    public  contractDetailId: number;


}
class CDTPDynamicTable {
    public  id:number;
    public  colNum:number;
    public  cdtp:ContractDetailTypeParam;
    public  cdtpId:number;
    public  headerType:string;
    public  headerValue:string;
    public  headerKey:string;
    public  valueType :string;
    public  required:boolean;
    public  regexValidator:string;
    public  defaultValue:string;
    public  maxRows :number;
    public  description:string;
}
class CDTPDynamicTableValue {
    public  id:number;

    public  cdtpDynamicTable:CDTPDynamicTable;

    public  cdtpDynamicTableId:number;

    public  rowNum:number;

    public  value:string;

    public  fieldName:string;

    public  contractDetailValue:ContractDetailValue;

    public  contractDetailValueId:number;

    public  description:string;

}

class SectionStackSectionObj  {
    position: number;
    template: string;
    expanded: boolean;
    contractDetailId: number;
    name: string;
    title: string;
    content: string;
    controls: isc.IButton[];
    items: Array<isc.ListGrid|isc.DynamicForm>
}