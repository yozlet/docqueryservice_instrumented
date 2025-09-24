export interface DocumentSearchRequest {
  search_text?: string;
  start_date?: string;
  end_date?: string;
  doc_type?: string;
  language?: string;
  country?: string;
}

export interface DocumentResult {
  id: string;
  title: string;
  abstract?: string;
  doc_date?: string;
  doc_type?: string;
  language?: string;
  country?: string;
}

export interface DocumentSearchResponse {
  results: DocumentResult[];
  result_count: number;
  search_time_ms: number;
}

export interface DocumentSummaryRequest {
  ids: string[];
  model?: string;
  model_options?: Record<string, string>;
}

export interface DocumentSummaryResponse {
  summary_text: string;
  summary_time_ms: number;
}

export interface ErrorResponse {
  error: string;
  message: string;
  details?: Record<string, unknown>;
}

