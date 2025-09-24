import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import {
  Box,
  Card,
  CardContent,
  Grid,
  TextField,
  Button,
  Typography,
  CircularProgress,
  Alert,
} from '@mui/material';
import { DatePicker } from '@mui/x-date-pickers';
import { documentService } from '../api/services';
import { DocumentSearchRequest, DocumentResult } from '../api/types';

export function SearchPage() {
  const [searchParams, setSearchParams] = useState<DocumentSearchRequest>({});

  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['documents', searchParams],
    queryFn: () => documentService.search(searchParams),
    enabled: false,
  });

  const handleSearch = () => {
    refetch();
  };

  return (
    <Box>
      <Typography variant="h4" gutterBottom>
        Document Search
      </Typography>

      <Card sx={{ mb: 4 }}>
        <CardContent>
          <Grid container spacing={3}>
            <Grid item xs={12}>
              <TextField
                fullWidth
                label="Search Text"
                value={searchParams.search_text || ''}
                onChange={(e) =>
                  setSearchParams((prev) => ({ ...prev, search_text: e.target.value }))
                }
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <DatePicker
                label="Start Date"
                value={searchParams.start_date ? new Date(searchParams.start_date) : null}
                onChange={(date) =>
                  setSearchParams((prev) => ({
                    ...prev,
                    start_date: date?.toISOString().split('T')[0],
                  }))
                }
                slotProps={{ textField: { fullWidth: true } }}
              />
            </Grid>
            <Grid item xs={12} sm={6}>
              <DatePicker
                label="End Date"
                value={searchParams.end_date ? new Date(searchParams.end_date) : null}
                onChange={(date) =>
                  setSearchParams((prev) => ({
                    ...prev,
                    end_date: date?.toISOString().split('T')[0],
                  }))
                }
                slotProps={{ textField: { fullWidth: true } }}
              />
            </Grid>
            <Grid item xs={12} sm={4}>
              <TextField
                fullWidth
                label="Document Type"
                value={searchParams.doc_type || ''}
                onChange={(e) =>
                  setSearchParams((prev) => ({ ...prev, doc_type: e.target.value }))
                }
              />
            </Grid>
            <Grid item xs={12} sm={4}>
              <TextField
                fullWidth
                label="Language"
                value={searchParams.language || ''}
                onChange={(e) =>
                  setSearchParams((prev) => ({ ...prev, language: e.target.value }))
                }
              />
            </Grid>
            <Grid item xs={12} sm={4}>
              <TextField
                fullWidth
                label="Country"
                value={searchParams.country || ''}
                onChange={(e) =>
                  setSearchParams((prev) => ({ ...prev, country: e.target.value }))
                }
              />
            </Grid>
            <Grid item xs={12}>
              <Button
                variant="contained"
                onClick={handleSearch}
                disabled={isLoading}
                fullWidth
              >
                {isLoading ? <CircularProgress size={24} /> : 'Search'}
              </Button>
            </Grid>
          </Grid>
        </CardContent>
      </Card>

      {error ? (
        <Alert severity="error">
          An error occurred while searching. Please try again.
        </Alert>
      ) : null}

      {data?.results.map((doc: DocumentResult) => (
        <Card key={doc.id} sx={{ mb: 2 }}>
          <CardContent>
            <Typography variant="h6" gutterBottom>
              {doc.title}
            </Typography>
            {doc.abstract && (
              <Typography variant="body2" color="text.secondary" paragraph>
                {doc.abstract}
              </Typography>
            )}
            <Grid container spacing={2}>
              {doc.doc_date && (
                <Grid item>
                  <Typography variant="body2">
                    Date: {new Date(doc.doc_date).toLocaleDateString()}
                  </Typography>
                </Grid>
              )}
              {doc.doc_type && (
                <Grid item>
                  <Typography variant="body2">Type: {doc.doc_type}</Typography>
                </Grid>
              )}
              {doc.language && (
                <Grid item>
                  <Typography variant="body2">Language: {doc.language}</Typography>
                </Grid>
              )}
              {doc.country && (
                <Grid item>
                  <Typography variant="body2">Country: {doc.country}</Typography>
                </Grid>
              )}
            </Grid>
          </CardContent>
        </Card>
      ))}

      {data && (
        <Box sx={{ mt: 2 }}>
          <Typography variant="body2" color="text.secondary">
            Found {data.result_count} documents in {data.search_time_ms}ms
          </Typography>
        </Box>
      )}
    </Box>
  );
}

