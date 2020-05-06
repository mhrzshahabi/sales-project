package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class TozinDTO {

    private String source;
    private String tozinId;
    private String nameKala;
    private Long codeKala;
    private String target;
    private String cardId;
    private String plak;
    private String carName;
    private String containerId;
    private String containerNo1;
    private String containerNo3;
    private String containerName;
    private Long vazn1;
    private Long vazn2;
    private String condition;
    private Long vazn;
    private Long tedad;
    private Long unitKala;
    private String packName;
    private String haveCode;
    private String date;
    private String tozinDate;
    private String tozinTime;
    private Long sourceId;
    private Long targetId;
    private String havalehName;
    private String havalehFrom;
    private String havalehTo;
    private String havalehDate;
    private String carNo1;
    private String carNo3;
    private String isFinal;
    private String ctrlDescOut;
    private String tznSharh2;
    private String strSharh2;
    private String tznSharh1;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("TozinInfo")
    public static class Info extends TozinDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class TozinIdDTO {
        private String source;
        private String tozinId;
        private String nameKala;
        private Long codeKala;
        private String target;
        private String cardId;
    }
}
