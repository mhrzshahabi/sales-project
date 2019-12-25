package com.nicico.sales.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractDTO;
import com.nicico.sales.iservice.IContractService;
import com.nicico.sales.model.entities.base.Contract;
import com.nicico.sales.repository.ContactDAO;
import com.nicico.sales.repository.ContractDAO;
import lombok.RequiredArgsConstructor;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.util.Units;
import org.apache.poi.wp.usermodel.HeaderFooterType;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.*;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.*;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.*;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@RequiredArgsConstructor
@Service
public class ContractService implements IContractService {

    private final ContractDAO contractDAO;
    private final ContactDAO contactDAO;
    private final ModelMapper modelMapper;
    private final Environment environment;

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_CONTRACT')")
    public ContractDTO.Info get(Long id) {
        final Optional<Contract> slById = contractDAO.findById(id);
        final Contract contract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractNotFound));

        return modelMapper.map(contract, ContractDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_CONTRACT')")
    public List<ContractDTO.Info> list() {
        final List<Contract> slAll = contractDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ContractDTO.Info>>() {
        }.getType());
    }

    @Override
    public void writeToWord(String request) throws IOException, InvalidFormatException, ParseException {
        String UPLOAD_FILE_DIR = environment.getProperty("nicico.upload.dir");
        XWPFDocument printdoc = new XWPFDocument();
        String dataALLArticle = "";
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = mapper.readValue(request, Map.class);
        String contractNo = map.get("contractNo") + "";
        Integer contractId = (Integer) map.get("contractId");
        printOnePage(printdoc, contractId);
        contractDAO.findById(contractId).getMaterial();
        map.remove("contractNo");
        map.remove("contractId");
        for (String key : map.keySet()) {
            String value = map.get(key) + "";
            dataALLArticle = dataALLArticle + " " + key + "&" + " " + value;
            XWPFParagraph paragraphPrint = printdoc.createParagraph();
            XWPFRun runPrint = paragraphPrint.createRun();
            XWPFRun runPrintValue = paragraphPrint.createRun();
            switch (key) {
                case "Article01":
                    runPrint.setText(key + "–DEFINITIONS:");
                    break;
                case "Article02":
                    runPrint.setText(key + "–OUANTITY:");
                    break;
                case "Article03":
                    runPrint.setText(key + "–OUALITY:");
                    break;
                case "Article04":
                    runPrint.setText(key + "–PACKING:");
                    break;
                case "Article05":
                    runPrint.setText(key + "–SHIPMENT:");
                    break;
                case "Article06":
                    runPrint.setText(key + "- DELIVERY TERMS:");
                    break;
                case "Article07":
                    runPrint.setText(key + "– PRICE:");
                    break;
                case "Article08":
                    runPrint.setText(key + "- QUOTATIONAL PERIOD:");
                    break;
                case "Article09":
                    runPrint.setText(key + "– PAYMENT:");
                    break;
                case "Article10":
                    runPrint.setText(key + "- CURRENCY CONVERSION:");
                    break;
                case "Article11":
                    runPrint.setText(key + "- TITLE AND RISK OF LOSS:");
                    break;
                case "Article12":
                    runPrint.setText(key + "– WEIGHT:");
                    break;
            }
            runPrint.setUnderline(UnderlinePatterns.SINGLE);
            runPrint.addBreak();
            runPrintValue.setText(value);
            runPrintValue.addBreak();
        }
        XWPFDocument doc = new XWPFDocument();
        String ContractWrite;
        String prefixContractWrite;
        String prefixPrintContractWrite;
        if (contractNo.contains("_Conc")) {
            ContractWrite = contractNo.replace("_Conc", "");
            prefixContractWrite = "Conc_";
            prefixPrintContractWrite = "PrintConc_";
        } else {
            ContractWrite = contractNo;
            prefixContractWrite = "Cathod_";
            prefixPrintContractWrite = "PrintCathod_";
        }
        OutputStream os = new FileOutputStream(UPLOAD_FILE_DIR + "/contract/" + prefixContractWrite + ContractWrite + ".doc");
            OutputStream printOs = new FileOutputStream(UPLOAD_FILE_DIR + "/contract/" + prefixPrintContractWrite + ContractWrite + ".doc");
            XWPFParagraph paragraph = doc.createParagraph();
            XWPFRun run = paragraph.createRun();
            //String base64Text = Base64.getEncoder().encodeToString(dataALLArticle.getBytes());
            run.setText(dataALLArticle);
            doc.write(os);
            printdoc.write(printOs);
    }

    @Override
    public List<String> readFromWord(String contractNo) {
        String UPLOAD_FILE_DIR = environment.getProperty("nicico.upload.dir");
        List<String> allArticle = new ArrayList<>();
        try {
            InputStream inputstream;
            if (contractNo.contains("_Conc")) {
                String contractConc = contractNo.replace("_Conc", "");
                inputstream = new FileInputStream(UPLOAD_FILE_DIR + "/contract/" + "Conc_" + contractConc.substring(1, contractConc.length() - 1) + ".doc");
            } else {
                inputstream = new FileInputStream(UPLOAD_FILE_DIR + "/contract/" + "Cathod_" + contractNo.substring(1, contractNo.length() - 1) + ".doc");
            }
            allArticle = extractText(inputstream);
        } catch (Exception e) {
            e.getMessage();
        }
        return allArticle;
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_CONTRACT')")
    public ContractDTO.Info create(ContractDTO.Create request) {
        final Contract contract = modelMapper.map(request, Contract.class);
        return save(contract);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_CONTRACT')")
    public ContractDTO.Info update(Long id, ContractDTO.Update request) {
        final Optional<Contract> slById = contractDAO.findById(id);
        final Contract contract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractNotFound));

        Contract updating = new Contract();
        modelMapper.map(contract, updating);
        modelMapper.map(request, updating);
        return save(updating);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_CONTRACT')")
    public void delete(Long id) {
        contractDAO.deleteById(id);
    }

    @Transactional
    @Override
    public String printContract(Long id) {
        Contract contract = contractDAO.findById(id).get();
        String flag=""  ;
        if(contract.getMaterial().getDescl().contains("Mo")){
            flag="PrintCathod_MO_"+contract.getContractNo();
        }else if(contract.getMaterial().getDescl().contains("Conc")){
            flag="PrintConc_"+contract.getContractNo();
        }else if(contract.getMaterial().getDescl().contains("Cath")){
            flag="PrintCathod_"+contract.getContractNo();
        }
        return flag;

    }



    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_CONTRACT')")
    public void delete(ContractDTO.Delete request) {
        final List<Contract> contracts = contractDAO.findAllById(request.getIds());

        contractDAO.deleteAll(contracts);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_BANK')")
    public TotalResponse<ContractDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(contractDAO, criteria, contract -> modelMapper.map(contract, ContractDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_CONTRACT')")
    public SearchDTO.SearchRs<ContractDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(contractDAO, request, contract -> modelMapper.map(contract, ContractDTO.Info.class));
    }



    private ContractDTO.Info save(Contract contract) {
        final Contract saved = contractDAO.saveAndFlush(contract);
        return modelMapper.map(saved, ContractDTO.Info.class);
    }

    private List<String> extractText(InputStream in) throws Exception {
        XWPFDocument doc = new XWPFDocument(in);
        XWPFWordExtractor ex = new XWPFWordExtractor(doc);
        String textAsli = ex.getText();
        String text = new String(textAsli);
        List<String> allArticles = new ArrayList<>();
        int a, b;
        for (int i = 1; i <= 12; i++) {
            if (i >= 9 && i != 12) {
                if (i == 9) {
                    a = text.lastIndexOf("Article0" + i + "&");
                } else {
                    a = text.lastIndexOf("Article" + i + "&");
                }
                b = text.indexOf("Article" + (i + 1) + "&", a);
            } else if (i == 12) {
                a = text.lastIndexOf("Article" + i + "&");
                b = text.length();
            } else {
                a = text.lastIndexOf("Article0" + i + "&");
                b = text.indexOf("Article0" + (i + 1) + "&", a);
            }

            if (a > b) {
                allArticles.add(text.substring(b, a));
            } else {
                allArticles.add(text.substring(a, b));
            }

        }
        return allArticles;
    }


    private void printOnePage(XWPFDocument printdoc, int contractId) throws IOException, InvalidFormatException, ParseException {
        String UPLOAD_FILE_DIR = environment.getProperty("nicico.upload.dir");
        CTSectPr sectPr = printdoc.getDocument().getBody().getSectPr();
        if (sectPr == null) sectPr = printdoc.getDocument().getBody().addNewSectPr();
        org.openxmlformats.schemas.wordprocessingml.x2006.main.CTPageMar pageMar = sectPr.getPgMar();
        if (pageMar == null) pageMar = sectPr.addNewPgMar();
        //pageMar.setLeft(BigInteger.valueOf(720)); //720 TWentieths of an Inch Point (Twips) = 720/20 = 36 pt = 36/72 = 0.5"
        pageMar.setRight(BigInteger.valueOf(720));
        pageMar.setTop(BigInteger.valueOf(720));
        pageMar.setBottom(BigInteger.valueOf(720));
        pageMar.setFooter(BigInteger.valueOf(720));
        pageMar.setHeader(BigInteger.valueOf(720));
        pageMar.setGutter(BigInteger.valueOf(0));
        // create header
        XWPFHeader header = printdoc.createHeader(HeaderFooterType.DEFAULT);
        XWPFParagraph headerParagraph = printdoc.createParagraph();
        XWPFRun run = headerParagraph.createRun();
        // header's first paragraph
        headerParagraph = header.getParagraphArray(0);
        if (headerParagraph == null) headerParagraph = header.createParagraph();
        headerParagraph.setAlignment(ParagraphAlignment.CENTER);
        FileInputStream in = new FileInputStream(UPLOAD_FILE_DIR + "/contract/" + "ArmNicico.JPG");
        run.addPicture(in, Document.PICTURE_TYPE_JPEG, "ArmNicico.JPG", Units.toEMU(400), Units.toEMU(75));
        in.close();

        XWPFTable tableNo = printdoc.createTable(1, 2);
        tableNo.getCTTbl().getTblPr().getTblBorders().unsetLeft();
        tableNo.getCTTbl().getTblPr().getTblBorders().unsetRight();
        tableNo.getCTTbl().getTblPr().getTblBorders().unsetInsideV();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date c = sdf.parse(contractDAO.findById(contractId).getContractDate());
        String date = sdf.format(c);

        tableNo.getRow(0).getCell(0).setText("DATE:" + " " + date);
        tableNo.getRow(0).getCell(0).setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
        tableNo.getRow(0).getCell(1).setText("NO:" + " " + contractDAO.findById(contractId).getContractNo());
        tableNo.getRow(0).getCell(1).setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
        CTTblWidth width = tableNo.getCTTbl().addNewTblPr().addNewTblW();
        width.setW(BigInteger.valueOf(10000));

        //create table
        XWPFTable table = printdoc.createTable(4, 2);

        table.getCTTbl().getTblPr().getTblBorders().unsetBottom();
        table.getCTTbl().getTblPr().getTblBorders().unsetTop();
        table.getCTTbl().getTblPr().getTblBorders().unsetLeft();
        table.getCTTbl().getTblPr().getTblBorders().unsetRight();
        table.getCTTbl().getTblPr().getTblBorders().unsetInsideH();
        table.getCTTbl().getTblPr().getTblBorders().unsetInsideV();

        //creating first row
        mergeCellHorizontally(table, 0, 0, 1);
        XWPFParagraph paragraph = table.getRow(0).getCell(0).addParagraph();
        paragraph.setAlignment(ParagraphAlignment.CENTER);
        setRun(paragraph.createRun(), "Calibre LIght", 8, "2b5079", "IN THE NAME OF GOD", true, false);
        /////***
        //creating two row
        mergeCellHorizontally(table, 1, 0, 1);
        XWPFParagraph paragraphTwo = table.getRow(1).getCell(0).addParagraph();
        paragraphTwo.setAlignment(ParagraphAlignment.LEFT);
        setRun(paragraphTwo.createRun(), "Calibre LIght", 5, "000000", "THIS SALES CONTRACT IS SIGNED AND STAMPED BETWEEN THE FOLLOWING COMPANIES AND BOTH PARTIES ARE OBLIGATED AND BOUND TO FULFILL THE FOLLOWINGS:", false, false);
        //creating three row
        XWPFParagraph paragraphBuyer =table.getRow(2).getCell(0).addParagraph();
        setRun(paragraphBuyer.createRun(), "Calibre LIght", 10, "000000", "BUYER:", true, true);
        if(contractDAO.findById(contractId).getContactId() != null) {
            setRun(paragraphBuyer.createRun(), "Calibre LIght", 6, "000000", "NAME:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactId()).get().getNameEN()), false, true);
            setRun(paragraphBuyer.createRun(), "Calibre LIght", 6, "000000", "PHONE:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactId()).get().getPhone()), false, true);
            setRun(paragraphBuyer.createRun(), "Calibre LIght", 6, "000000", "MOBILE:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactId()).get().getMobile()), false, true);
            setRun(paragraphBuyer.createRun(), "Calibre LIght", 6, "000000", "ADDRESS:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactId()).get().getAddress()), false, true);
        }
        //table.getRow(2).getCell(0).setText("BUYER:\n" + contactDAO.findById(contractDAO.findById(contractId).getContactId()).get().getNameEN());
        //table.getRow(2).getCell(1).setText("AGENT BUYER:\n" + contactDAO.findById(contractDAO.findById(contractId).getContactByBuyerAgentId()).get().getNameEN());
        XWPFParagraph paragraphAgentBuyer =table.getRow(2).getCell(1).addParagraph();
        setRun(paragraphAgentBuyer.createRun(), "Calibre LIght", 10, "000000", "AGENT BUYER:", true, true);
        if(contractDAO.findById(contractId).getContactByBuyerAgentId() != null) {
            setRun(paragraphAgentBuyer.createRun(), "Calibre LIght", 6, "000000", "NAME:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactByBuyerAgentId()).get().getNameEN()), false, true);
            setRun(paragraphAgentBuyer.createRun(), "Calibre LIght", 6, "000000", "PHONE:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactByBuyerAgentId()).get().getPhone()), false, true);
            setRun(paragraphAgentBuyer.createRun(), "Calibre LIght", 6, "000000", "MOBILE:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactByBuyerAgentId()).get().getMobile()), false, true);
            setRun(paragraphAgentBuyer.createRun(), "Calibre LIght", 6, "000000", "ADDRESS:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactByBuyerAgentId()).get().getAddress()), false, true);
        }
        //creating four row
        XWPFParagraph paragraphSeller =table.getRow(3).getCell(0).addParagraph();
        setRun(paragraphSeller.createRun(), "Calibre LIght", 10, "000000", "SELLER:", true, true);
        if(contractDAO.findById(contractId).getContactBySellerId() != null) {
            setRun(paragraphSeller.createRun(), "Calibre LIght", 6, "000000", "NAME:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactBySellerId()).get().getNameEN()), false, true);
            setRun(paragraphSeller.createRun(), "Calibre LIght", 6, "000000", "PHONE:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactBySellerId()).get().getPhone()), false, true);
            setRun(paragraphSeller.createRun(), "Calibre LIght", 6, "000000", "MOBILE:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactBySellerId()).get().getMobile()), false, true);
            setRun(paragraphSeller.createRun(), "Calibre LIght", 6, "000000", "ADDRESS:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactBySellerId()).get().getAddress()), false, true);
        }
        //table.getRow(3).getCell(0).setText("SELLER:\n" + contactDAO.findById(contractDAO.findById(contractId).getContactBySellerId()).get().getNameEN());
        ////******
        XWPFParagraph paragraphAgentSeller =table.getRow(3).getCell(1).addParagraph();
        setRun(paragraphAgentSeller.createRun(), "Calibre LIght", 10, "000000", "AGENT SELLER:", true, true);
        if(contractDAO.findById(contractId).getContactBySellerAgentId() != null) {
            setRun(paragraphAgentSeller.createRun(), "Calibre LIght", 6, "000000", "NAME:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactBySellerAgentId()).get().getNameEN()), false, true);
            setRun(paragraphAgentSeller.createRun(), "Calibre LIght", 6, "000000", "PHONE:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactBySellerAgentId()).get().getPhone()), false, true);
            setRun(paragraphAgentSeller.createRun(), "Calibre LIght", 6, "000000", "MOBILE:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactBySellerAgentId()).get().getMobile()), false, true);
            setRun(paragraphAgentSeller.createRun(), "Calibre LIght", 6, "000000", "ADDRESS:" + " " + nvl(contactDAO.findById(contractDAO.findById(contractId).getContactBySellerAgentId()).get().getAddress()), false, true);
        }
        //table.getRow(3).getCell(1).setText("AGENT SELLER:\n" + contactDAO.findById(contractDAO.findById(contractId).getContactBySellerAgentId()).get().getNameEN());


        table.getRow(0).setHeight(50);
        table.getRow(1).setHeight(200);
        table.getRow(2).setHeight(1500);
        table.getRow(3).setHeight(1500);
        CTTblWidth widthContact = table.getCTTbl().addNewTblPr().addNewTblW();
        widthContact.setW(BigInteger.valueOf(10000));
    }


    private String nvl(String in){ return in == null ? "" : in; }

    private void setRun(XWPFRun run, String fontFamily, int fontSize, String colorRGB, String text, boolean bold, boolean addBreak) {
        run.setFontFamily(fontFamily);
        run.setFontSize(fontSize);
        run.setColor(colorRGB);
        run.setText(text);
        run.setBold(bold);
        if (addBreak) run.addBreak();
    }

    private void mergeCellVertically(XWPFTable table, int col, int fromRow, int toRow) {
        for (int rowIndex = fromRow; rowIndex <= toRow; rowIndex++) {
            XWPFTableCell cell = table.getRow(rowIndex).getCell(col);
            CTVMerge vmerge = CTVMerge.Factory.newInstance();
            if (rowIndex == fromRow) {
                // The first merged cell is set with RESTART merge value
                vmerge.setVal(STMerge.RESTART);
            } else {
                // Cells which join (merge) the first one, are set with CONTINUE
                vmerge.setVal(STMerge.CONTINUE);
                // and the content should be removed
                for (int i = cell.getParagraphs().size(); i > 0; i--) {
                    cell.removeParagraph(0);
                }
                cell.addParagraph();
            }
            // Try getting the TcPr. Not simply setting an new one every time.
            CTTcPr tcPr = cell.getCTTc().getTcPr();
            if (tcPr == null) tcPr = cell.getCTTc().addNewTcPr();
            tcPr.setVMerge(vmerge);
        }
    }

    //merging horizontally by setting grid span instead of using CTHMerge
    private void mergeCellHorizontally(XWPFTable table, int row, int fromCol, int toCol) {
        XWPFTableCell cell = table.getRow(row).getCell(fromCol);
        // Try getting the TcPr. Not simply setting an new one every time.
        CTTcPr tcPr = cell.getCTTc().getTcPr();
        if (tcPr == null) tcPr = cell.getCTTc().addNewTcPr();
        // The first merged cell has grid span property set
        if (tcPr.isSetGridSpan()) {
            tcPr.getGridSpan().setVal(BigInteger.valueOf(toCol - fromCol + 1));
        } else {
            tcPr.addNewGridSpan().setVal(BigInteger.valueOf(toCol - fromCol + 1));
        }
        // Cells which join (merge) the first one, must be removed
        for (int colIndex = toCol; colIndex > fromCol; colIndex--) {
            table.getRow(row).getCtRow().removeTc(colIndex);
            table.getRow(row).removeCell(colIndex);
        }
    }

}
