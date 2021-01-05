interface Inventory {
    id: number;
}

interface Depot {
    id: number;

}

///<reference path="Contract1.ts"/>
interface RemittanceDetail {
    id: number;

    amount: number;

    // @ts-ignore
    unit: Unit;

    unitId: number;

    remittance: Remittance;

    remittanceId: number;

    inventory: Inventory;

    inventoryId: number;

    depot: Depot;

    depotId: number;

    sourceTozin: TozinTable;

    sourceTozinId: number;

    destinationTozin: TozinTable;

    destinationTozinId: number;

    railPolompNo: string;

    securityPolompNo: string;

    description: string;

    weight: number;

    date: string;

    inputRemittance: boolean;

    tozin: TozinTable;

}

interface Shipment {
    id: number;

}

interface WeightInspection {
    id: number

}

interface AssayInspection {
    id: number

}

interface Inventory {
    id: number;

    materialItem: MaterialItem;

    materialItemId: number;

    label: string;

    remittanceDetails: RemittanceDetail[];


    assayInspections: AssayInspection[];

    weightInspection: WeightInspection;

    weightInspections: WeightInspection[];

    weight: number;

    amount: number;

    // @ts-ignore
    contract: Contract1;

    contractId: number;

}

interface MaterialItem {
    id: number

}

interface Warehouse {
    id: number

}

interface TozinTable {
    id: number;

    tozinId: string;

    isInView: boolean;

    sourceId: number;

    sourceWarehouse: Warehouse;

    targetId: number;

    targetWarehouse: Warehouse;

    cardId: string;

    haveCode: string;

    vazn: number;

    date: string;

    ctrlDescOut: string;

    plak: string;

    driverName: string;

    codeKala: number;

    materialItem: MaterialItem;

    containerNo3: string;

    remittanceDetailsAsDestination: RemittanceDetail[];

    remittanceDetailsAsSource: RemittanceDetail[];

}

interface Remittance {
    id: number;

    code: string;

    remittanceDetails: RemittanceDetail[];

    description: string;

    shipment: Shipment;

    shipmentId: number;

    date: string;

    tozinTable: TozinTable;

}

interface BillOfLanding {
    id: number;
}

interface PackingList {
    id: number;

    billOfLanding: BillOfLanding;

    billOfLandingId: number;

    shipment: Shipment;

    shipmentId: number;

    bookingNo: string;

    description: string;

}

interface InRemittance {
    remittance: string,
    remittanceDetails: RemittanceDetail[]
}