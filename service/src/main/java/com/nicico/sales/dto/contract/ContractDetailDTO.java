package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.dto.CDTPDynamicTableValueDTO;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.*;
import java.util.stream.Collectors;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ContractDetailDTO {

    private String content;
    private Long contractId;
    private Long contractDetailTypeId;
    private String contractDetailTemplate;
    private Integer position;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailInfo")
    public static class Info extends ContractDetailDTO {

        private Long id;

        private ContractDetailTypeDTO.Info contractDetailType;
        private List<ContractDetailValueDTO.Info> contractDetailValues;
        private Map<String, List<Map<String, String>>> cdtpDynamicTableValue;

        public Map<String, List<Map<String, String>>> getCdtpDynamicTableValue() {
            List<Map<String, String>> returnList = new ArrayList<>();
            Map<String, List<CDTPDynamicTableValueDTO.Info>> baseOnKey = new HashMap<>();
            contractDetailValues
                    .stream()
                    .filter(c -> c.getCdtpDynamicTableValue() != null).forEach(c -> {
                if (!baseOnKey.containsKey(c.getKey())) {
                    baseOnKey.put(c.getKey(), new ArrayList<CDTPDynamicTableValueDTO.Info>(Collections.singletonList(c.getCdtpDynamicTableValue())));
                } else {
                    baseOnKey.get(c.getKey()).add(c.getCdtpDynamicTableValue());
                }
            });

            Map<String, List<Map<String, String>>> returnMap = new HashMap<>();

            baseOnKey.keySet().forEach(k -> returnMap.put(k, getCDTPDynamicTableMap(baseOnKey.get(k))));


            return returnMap;
        }

        private List<Map<String, String>> getCDTPDynamicTableMap(List<CDTPDynamicTableValueDTO.Info> cdtpDynamicTableValueList) {
            List<Map<String, String>> returnList = new ArrayList<>();
            if (cdtpDynamicTableValueList.size() == 0) return returnList;
            cdtpDynamicTableValueList.sort(CDTPDynamicTableValueDTO.Info::compareTo);
            final Set<Integer> rowNums = cdtpDynamicTableValueList.stream().map(CDTPDynamicTableValueDTO::getRowNum).sorted().collect(Collectors.toSet());
            for (int i = 0; i < rowNums.size(); i++) {
                Integer _rowNum = Integer.valueOf(rowNums.toArray()[i].toString());
                Map<String, String> rowData = new HashMap<String, String>();
                rowData.put("cdtpDtId____", "");
                rowData.put("cdtpDtValueId____", "");

                cdtpDynamicTableValueList
                        .stream()
                        .filter(rowNum -> rowNum.getRowNum()
                                .equals(_rowNum)).forEach(c -> {
                    rowData.put(c.getFieldName(), c.getValue());
                    rowData.put("cdtpId____", c.getCdtpDynamicTable().getCdtpId().toString());
                    rowData.put("rowNum____", _rowNum.toString());
                    rowData.put("cdtpDtId____", String.format("%s,\"%s\":%s",
                            rowData.get("cdtpDtId____"),
                            c.getFieldName(), c.getCdtpDynamicTableId().toString()
                    ));
                    rowData.put("cdtpDtValueId____", String.format("%s,\"%s\":%s",
                            rowData.get("cdtpDtValueId____"),
                            c.getFieldName(), c.getId().toString()
                    ));
                });
                rowData.put("cdtpDtId____", String.format("{%s}",
                        rowData.get("cdtpDtId____").substring(1)));
                rowData.put("cdtpDtValueId____", String.format("{%s}",
                        rowData.get("cdtpDtValueId____").substring(1)));
                returnList.add(rowData);

            }
            return returnList;
        }


        // Auditing
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;

        // BaseEntity
        private Boolean editable;
        private List<EStatus> eStatus;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailCreateRq")
    public static class Create extends ContractDetailDTO {
        private List<ContractDetailValueDTO.Create> contractDetailValues;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailUpdateRq")
    public static class Update extends ContractDetailDTO {

        private ContractDetailTypeDTO.Update contractDetailType;
        private List<ContractDetailValueDTO.Update> contractDetailValues;

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContractDetailDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

}
