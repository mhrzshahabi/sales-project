package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nicico.sales.model.entities.base.Country;
import com.nicico.sales.model.entities.base.Material;
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
public class ExportDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private Material material;
	private Long materialId;
	private Country country;
	private Long countryId;
	private String loadingLetterNo;
	private String loadingLetterDate;
	private Double amount;
	private Double containerQuantity;
	private String shipDate;
	private String cargo;

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ExportInfo")
	public static class Info extends ExportDTO {
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
	@ApiModel("ExportCreateRq")
	public static class Create extends ExportDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("ExportUpdateRq")
	public static class Update extends ExportDTO {
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
	@ApiModel("ExportDeleteRq")
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
	@ApiModel("ExportSpecRs")
	public static class ExportSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<ExportDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
