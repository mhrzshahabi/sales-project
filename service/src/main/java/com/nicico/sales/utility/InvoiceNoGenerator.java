package com.nicico.sales.utility;

import com.nicico.sales.repository.ShipmentCostInvoiceDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class InvoiceNoGenerator {

    private final ShipmentCostInvoiceDAO shipmentCostInvoiceDAO;

    public String createInvoiceNo(String invoiceTypeTitle, Integer persianYear, Integer persianMonth, String matAbbreviation, String contractNo) {

        String base = String.format(String.valueOf(persianYear % 100), "00") +
                String.format(String.valueOf(persianMonth), "00") + "/" +
                matAbbreviation + "-" + contractNo + "/";
        Long invoiceSeq = shipmentCostInvoiceDAO.findNextInvoiceSequence();

        switch (invoiceTypeTitle) {
            case "PROFORMA":
                base = base + "01" + invoiceSeq;
                break;
            case "PROVISIONAL":
                base = base + "02" + invoiceSeq;
                break;
            case "FINAL":
                base = base + "03" + invoiceSeq;
                break;
            case "TRUSTY":
                base = base + "04" + invoiceSeq;
                break;
            case "INSPECTION":
                base = base + "05" + invoiceSeq;
                break;
            case "INSURANCE":
                base = base + "06" + invoiceSeq;
                break;
            case "THC":
                base = base + "07" + invoiceSeq;
                break;
            case "BL FEE":
                base = base + "08" + invoiceSeq;
                break;
            case "UMPIRE LAB":
                base = base + "09" + invoiceSeq;
                break;
            case "DEMAND":
                base = base + "10" + invoiceSeq;
                break;
            case "FREIGHT":
                base = base + "11" + invoiceSeq;
                break;
            case "DISPATCH":
                base = base + "12" + invoiceSeq;
                break;
            case "DEMURRAGE":
                base = base + "13" + invoiceSeq;
                break;
            default:
                break;
        }

        return base;
    }
}
