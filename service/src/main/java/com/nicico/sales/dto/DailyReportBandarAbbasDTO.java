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
public class DailyReportBandarAbbasDTO {
	private String warehouse;
	private String toDay;
	private Long materialId;
	private String plant;
	private String packingType;
	private Double amountDay;
	private Double amountFirstDay;
	private Double amountImportDay;
	private Double amountExportDay;
	private Double amountReviseDay;
	private Double amountFirstMon;
	private Double amountImportMon;
	private Double amountExportMon;
	private Double amountReviseMon;
	private Double amountFirstSal;
	private Double amountImportSal;
	private Double amountExportSal;
	private Double amountReviseSal;
	private Double reviseSal;

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("DailyReportBandarAbbasInfo")
	public static class Info extends DailyReportBandarAbbasDTO {
		private MaterialDTO.MaterialTuple material;
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
	@ApiModel("DailyReportBandarAbbasCreateRq")
	public static class Create extends DailyReportBandarAbbasDTO {
	}

	// ------------------------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("DailyReportBandarAbbasUpdateRq")
	public static class Update extends DailyReportBandarAbbasDTO {
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
	@ApiModel("DailyReportBandarAbbasDeleteRq")
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
	@ApiModel("DailyReportBandarAbbasSpecRs")
	public static class DailyReportBandarAbbasSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<DailyReportBandarAbbasDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
