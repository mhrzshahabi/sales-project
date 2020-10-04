package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ContactDTO {

    private String nameFA;
    private String nameEN;
    private String name;
    private String phone;
    private String mobile;
    private String fax;
    private String address;
    private String webSite;
    private String email;
    private Boolean type;
    private String nationalCode;
    private String economicalCode;
    private Boolean status;
    private String tradeMark;
    private String commercialRegistration;
    private String branchName;
    private String commercialRole;
    private Boolean seller;
    private Boolean buyer;
    private Boolean transporter;
    private Boolean shipper;
    private Boolean inspector;
    private Boolean insurancer;
    private Boolean agentBuyer;
    private Boolean agentSeller;
    private String ceo;
    private String ceoPassportNo;
    private Long countryId;
    private String postalCode;
    private String registerNumber;

    @Getter
    @Setter
    @ApiModel("ContactInfoTuple")
    public static class ContactInfoTuple {
        private Long id;
        private String nameFA;
        private String nameEN;
        private String name;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContactInfo")
    public static class Info extends ContactDTO {
        private Long id;
        private BankDTO bank;
        private CountryDTO country;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
        private ContactAccountDTO.Info defaultAccount;

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContactCreateRq")
    public static class Create extends ContactDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContactUpdateRq")
    public static class Update extends ContactDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("ContactDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
