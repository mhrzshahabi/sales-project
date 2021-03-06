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
public class PersonDTO {

    private Long contactId;
    private String fullName;
    private String jobTitle;
    private String title;
    private String email;
    private String email1;
    private String email2;
    private String webAddress;
    private String phoneNo;
    private String faxNo;
    private String mobileNo;
    private String mobileNo1;
    private String mobileNo2;
    private String whatsApp;
    private String weChat;
    private String address;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PersonInfo")
    public static class Info extends PersonDTO {
        private Long id;
        private Date createdDate;
        private String createdBy;
        private Date lastModifiedDate;
        private String lastModifiedBy;
        private Integer version;
        private ContactDTO contact;

    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PersonCreateRq")
    public static class Create extends PersonDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PersonUpdateRq")
    public static class Update extends PersonDTO {
        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("PersonDeleteRq")
    public static class Delete {
        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
