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
public class RateDTO {

	private String nameFA;
	private String nameEN;
	private String symbol;
	private Long decimalDigit;

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("RateInfo")
	public static class Info extends RateDTO {
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
	@ApiModel("RateCreateRq")
	public static class Create extends RateDTO {
	}

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("RateUpdateRq")
	public static class Update extends RateDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
	}

	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("RateDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("RateSpecRs")
	public static class RateSpecRs {
		private SpecRs response;
	}

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<RateDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
