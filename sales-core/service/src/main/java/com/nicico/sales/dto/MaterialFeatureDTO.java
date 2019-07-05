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
public class MaterialFeatureDTO {
	private Long itemRow;
	private Double minValue;
	private Double maxValue;
	private Double avgValue;
	private Double tolorance;
	private Double payableIfGraterThan;
	private Double paymentPercent;
	private Double TC;
	private Double RC;

	@ApiModelProperty(required = true)
	private Long materialId;
	@ApiModelProperty(required = true)
	private Long featureId;
	@ApiModelProperty(required = true)
	private Long rateId;
	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("MaterialFeatureInfo")
	public static class Info extends MaterialFeatureDTO {
		private RateDTO rate;
		private FeatureDTO feature;
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
	@ApiModel("MaterialFeatureCreateRq")
	public static class Create extends MaterialFeatureDTO {

	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("MaterialFeatureUpdateRq")
	public static class Update extends MaterialFeatureDTO {
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
	@ApiModel("MaterialFeatureDeleteRq")
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
	@ApiModel("MaterialFeatureSpecRs")
	public static class MaterialFeatureSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<MaterialFeatureDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
