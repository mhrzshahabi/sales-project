package com.nicico.sales.utility;

import java.util.List;

public class AccountingGridResponse<T> {
	private List<T> data;
	private int status;
	private int startRow;
	private int endRow;
	private int totalRows;
	private Boolean invalidatCache;
	public AccountingGridResponse() {
	}

	public AccountingGridResponse(List<T> data, int status, int startRow, int endRow, int totalRows) {
		this.data = data;
		this.status = status;
		this.startRow = startRow;
		this.endRow = endRow;
		this.totalRows = totalRows;
	}

	public AccountingGridResponse(List<T> data) {
		if (data == null) {
			this.status = 0;
			this.startRow = 0;
			this.endRow = 0;
			this.totalRows = 0;
		}
		this.data = data;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public int getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}

	public List<T> getData() {
		return data;
	}

	public void setData(List<T> data) {
		this.data = data;
	}

	public Boolean getInvalidatCache() {
		return invalidatCache;
	}

	public void setInvalidatCache(Boolean invalidatCache) {
		this.invalidatCache = invalidatCache;
	}
}
