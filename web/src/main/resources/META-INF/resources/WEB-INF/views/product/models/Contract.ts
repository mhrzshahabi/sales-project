///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts"/>
interface Unit {
    id: number;
}

enum DataType {
    PersianDate = 1,
    GeorgianDate,//(2),
    Boolean,//(3),
    BigDecimal,//(4),
    FIVE,
    Integer,//(6),
    Long,//(7),
    String,//(8),
    Reference,//(9),
    ListOfReference,//(10),
    DynamicTable,//(11);
}

interface Contract1 {
    id: number;

}

interface Material {
    id: number;
}

interface ContractDetailTypeTemplate {
    id: number;
}

interface ContractDetailType {
    id: number;

    code: string

    material: Material

    materialId: number

    titleFa: string

    titleEn: string

    contractDetailTypeParams: ContractDetailTypeParam[]

    contractDetailTypeTemplates: ContractDetailTypeTemplate[]


}

interface ContractDetailTypeParam {
    id: number;
    name: string;

    key: string;

    type: DataType;

    reference: string;

    defaultValue: string;

    required: boolean;

    unit: Unit;

    unitId: number;

    contractDetailType: ContractDetailType;

    contractDetailTypeId: number;

    dynamicTables: CDTPDynamicTable[];

}

interface ContractDetail {
    id: number;

    content: string;

    contract: Contract1;

    contractId: number;

    contractDetailType: ContractDetailType;

    contractDetailTypeId: number;

    contractDetailTemplate: string;

    contractDetailValues: ContractDetailValue[];

    cdtpDynamicTableValue: { [key: string]: { cdtpId____: string, rowNum____: string, cdtpDtId____: string, [key: string]: string }[] };

    position: number;

}

interface ContractDetailValue {
    id: number;

    name: string;

    key: string;

    title: string;

    type: DataType;

    reference: string;

    required: boolean;

    value: string;

    unit: Unit;

    unitId: number;

    contractDetail: ContractDetail;

    contractDetailId: number;


}

interface CDTPDynamicTable {
    id: number;
    colNum: number;
    cdtp: ContractDetailTypeParam;
    cdtpId: number;
    headerType: string;
    headerValue: string;
    headerKey: string;
    valueType: string;
    required: boolean;
    regexValidator: string;
    defaultValue: string;
    maxRows: number;
    description: string;
    initialCriteria: string;
}

interface CDTPDynamicTableValue {
    id: number;

    cdtpDynamicTable: CDTPDynamicTable;

    cdtpDynamicTableId: number;

    rowNum: number;

    value: string;

    fieldName: string;

    contractDetailValue: ContractDetailValue;

    contractDetailValueId: number;

    description: string;

}

interface SectionStackSectionObj {
    position: number;
    template: string;
    expanded: boolean;
    contractDetailId: number;
    name: string;
    title: string;
    content: string;
    controls: isc.IButton[];
    items: Array<isc.ListGrid | isc.DynamicForm>
}