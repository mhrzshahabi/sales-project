package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.ContractItem;
import com.nicico.sales.model.entities.base.Feature;
import com.nicico.sales.model.entities.base.Rate;
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
public class ContractItemFeatureDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private ContractItem contractItem;
	private Long contractItemId;
	private Long itemRow;
	private Feature feature;
	private Long featureId;
	private Double minValue;
	private Double maxValue;
	private Double avgValue;
	private Double tolorance;
	private Rate rate;
	private Long rateId;
	private Double payableIfGraterThan;
	private Double discountIfGraterThan;
	private Double paymentPercent;
	private Double TC;
	private Double RC;
	private String unitDiduction;

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractItemFeatureInfo")
	public static class Info extends ContractItemFeatureDTO {
		private Long id;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractItemFeatureCreateRq")
	public static class Create extends ContractItemFeatureDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractItemFeatureUpdateRq")
	public static class Update extends ContractItemFeatureDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
		@NotNull
		@ApiModelProperty(required = true)
		private Integer version;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ContractItemFeatureDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("ContractItemFeatureSpecRs")
	public static class ContractItemFeatureSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ContractItemFeatureDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
