import { apiClient } from './client';
import {
  DocumentSearchRequest,
  DocumentSearchResponse,
  DocumentSummaryRequest,
  DocumentSummaryResponse,
} from './types';

export const documentService = {
  search: async (request: DocumentSearchRequest): Promise<DocumentSearchResponse> => {
    const response = await apiClient.post<DocumentSearchResponse>('/search', request);
    return response.data;
  },

  generateSummary: async (request: DocumentSummaryRequest): Promise<DocumentSummaryResponse> => {
    const response = await apiClient.post<DocumentSummaryResponse>('/summary', request);
    return response.data;
  },
};

