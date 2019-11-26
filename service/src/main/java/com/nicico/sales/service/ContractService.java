package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractDTO;
import com.nicico.sales.iservice.IContractService;
import com.nicico.sales.model.entities.base.Contract;
import com.nicico.sales.repository.ContractDAO;
import lombok.RequiredArgsConstructor;
import org.activiti.engine.impl.util.json.JSONObject;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.function.Consumer;

@RequiredArgsConstructor
@Service
public class ContractService implements IContractService {

    private final ContractDAO contractDAO;
    private final ModelMapper modelMapper;
    private final Environment environment;
    String dataALLArticle = "";

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
    public void writeToWord(String request) {
        String UPLOAD_FILE_DIR = environment.getProperty("nicico.upload.dir");
        JSONObject jsonObject = new JSONObject(request);
        String contractNo = jsonObject.getString("contractNo");
        jsonObject.remove("contractNo");
        jsonObject.sortedKeys().forEachRemaining(new Consumer() {
            @Override
            public void accept(Object s) {
                String key = s.toString();
                String value = jsonObject.getString(key);
                dataALLArticle = dataALLArticle + " " + key + "&" + " " + value;
            }
        });
        XWPFDocument doc = new XWPFDocument();
        try (OutputStream os = new FileOutputStream(UPLOAD_FILE_DIR + "/contract/" + "Cathod_" + contractNo + ".doc")) {
            XWPFParagraph paragraph = doc.createParagraph();
            XWPFRun run = paragraph.createRun();
            //String base64Text = Base64.getEncoder().encodeToString(dataALLArticle.getBytes());
            run.setText(dataALLArticle);
            doc.write(os);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }

    @Override
    public List<String> readFromWord(String contractNo) {
        String UPLOAD_FILE_DIR = environment.getProperty("nicico.upload.dir");
        List<String> allArticle = new ArrayList<>();
        try {
            InputStream inputstream = new FileInputStream(UPLOAD_FILE_DIR + "/contract/" + "Cathod_" + contractNo.substring(1, contractNo.length() - 1) + ".doc");
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
//    @PreAuthorize("hasAuthority('D_CONTRACT')")
    public void delete(ContractDTO.Delete request) {
        final List<Contract> contracts = contractDAO.findAllById(request.getIds());

        contractDAO.deleteAll(contracts);
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
        // String base64 = textAsli.replaceAll("\n", "");
        //byte bytes[] = Base64.getDecoder().decode(base64);
        String text = new String(textAsli);
        List<String> allArticles = new ArrayList<>();
        int a, b;
        for (int i = 3; i <= 12; i++) {
            if (i >= 9 && i!=12) {
                if (i == 9) {
                    a = text.lastIndexOf("Article0" + i + "&");
                } else {
                    a = text.lastIndexOf("Article" + i + "&");
                }
                    b = text.indexOf("Article" + (i + 1) + "&", a);
            }else if (i==12){
                a = text.lastIndexOf("Article" + i + "&");
                b = text.length();
            }
            else {
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
}
