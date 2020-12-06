package com.nicico.sales.dto.contract;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.enumeration.EStatus;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class IncotermDTO {

    private String title;
    private Date publishDate;
    private String description;
    private Long incotermVersionId;

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermInfo")
    public static class Info extends IncotermDTO {

        IncotermVersionDTO.Info incotermVersion;
        private Long id;
        private List<IncotermRulesDTO.Info> incotermRules;
        private List<IncotermStepsDTO.Info> incotermSteps;

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
    @ApiModel("FormTupleRq")
    public static class FormTuple {

        private Byte order;
        private Long incotermFormId;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("StepTupleRq")
    public static class StepTuple {

        private Byte order;
        private Long incotermStepId;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("RuleTupleRq")
    public static class RuleTuple {

        private Byte order;
        private Long incotermRuleId;
        private List<FormTuple> incotermForms;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermCreateRq")
    public static class Create extends IncotermDTO {

        private List<StepTuple> incotermSteps;
        private List<RuleTuple> incotermRules;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermUpdateRq")
    public static class Update extends IncotermDTO {

        @NotNull
        @ApiModelProperty(required = true)
        private Long id;
        private List<StepTuple> incotermSteps;
        private List<RuleTuple> incotermRules;

        private Integer version;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermDeleteRq")
    public static class Delete {

        @NotNull
        @ApiModelProperty(required = true)
        private List<Long> ids;
    }

    @Getter
    @Setter
    @Accessors(chain = true)
    @ApiModel("IncotermViewForContract")
    @AllArgsConstructor
    public static class ViewForContract {
        private String id;
        private String title;
        private List<IncotermRulesDTO.Info> incotermRules;

        public String getDescription() {

            String t = getTitle();
            List<IncotermRulesDTO.Info> rules = getIncotermRules();
            if (t != null && rules != null && rules.size() > 0)
                return t + " (" + rules.stream().map(q -> q.getIncotermRule().getCode()).collect(Collectors.joining(", ")) + ")";

            return "";
        }
    }
}
