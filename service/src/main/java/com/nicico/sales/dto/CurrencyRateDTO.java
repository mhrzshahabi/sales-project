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
public class CurrencyRateDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private String curDate;
	private String irrUsd;
	private String eurUsd;
	private String aedUsd;
	private String rmbUsd;


	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("CurrencyRateInfo")
	public static class Info extends CurrencyRateDTO {
		private Long id;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("CurrencyRateCreateRq")
	public static class Create extends CurrencyRateDTO {
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("CurrencyRateUpdateRq")
	public static class Update extends CurrencyRateDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
		@NotNull
		@ApiModelProperty(required = true)
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("CurrencyRateDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("CurrencyRateSpecRs")
	public static class CurrencyRateSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<CurrencyRateDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
