package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.enumeration.EStatus;
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
public class IncotermRulesDTO {

    private Byte order;
    private Long incotermId;
    private Long incotermRuleId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermRulesInfo")
    public static class Info extends IncotermRulesDTO {

        private Long id;
        private IncotermDTO incoterm;
        private IncotermRuleDTO.Info incotermRule;
        private List<IncotermFormsDTO.Info> incotermForms;

        public String getIncotermRuleTitleFa() {

            if (this.incotermRule == null)
                return null;

            return this.incotermRule.getTitleFa();
        }

        public String getIncotermRuleTitleEn() {

            if (this.incotermRule == null)
                return null;

            return this.incotermRule.getTitleEn();
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
    @ApiModel("IncotermRulesCreateRq")
    public static class Create extends IncotermRulesDTO {
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermRulesUpdateRq")
    public static class Update extends IncotermRulesDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermRulesDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }
}
