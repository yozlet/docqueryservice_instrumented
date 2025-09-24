import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import {
  Box,
  Card,
  CardContent,
  TextField,
  Button,
  Typography,
  CircularProgress,
  Alert,
} from '@mui/material';
import { documentService } from '../api/services';
import { DocumentSummaryRequest } from '../api/types';

export function SummaryPage() {
  const [documentIds, setDocumentIds] = useState<string>('');
  const [model, setModel] = useState<string>('gpt-4');

  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['summary', documentIds, model],
    queryFn: () =>
      documentService.generateSummary({
        ids: documentIds.split(',').map((id) => id.trim()),
        model,
      } as DocumentSummaryRequest),
    enabled: false,
  });

  const handleGenerateSummary = () => {
    if (documentIds.trim()) {
      refetch();
    }
  };

  return (
    <Box>
      <Typography variant="h4" gutterBottom>
        Document Summary
      </Typography>

      <Card sx={{ mb: 4 }}>
        <CardContent>
          <TextField
            fullWidth
            label="Document IDs (comma-separated)"
            value={documentIds}
            onChange={(e) => setDocumentIds(e.target.value)}
            sx={{ mb: 2 }}
          />
          <TextField
            fullWidth
            label="AI Model"
            value={model}
            onChange={(e) => setModel(e.target.value)}
            sx={{ mb: 2 }}
          />
          <Button
            variant="contained"
            onClick={handleGenerateSummary}
            disabled={isLoading || !documentIds.trim()}
            fullWidth
          >
            {isLoading ? <CircularProgress size={24} /> : 'Generate Summary'}
          </Button>
        </CardContent>
      </Card>

      {error ? (
        <Alert severity="error">
          An error occurred while generating the summary. Please try again.
        </Alert>
      ) : null}

      {data && (
        <Card>
          <CardContent>
            <Typography variant="h6" gutterBottom>
              Summary
            </Typography>
            <Typography variant="body1" paragraph>
              {data.summary_text}
            </Typography>
            <Typography variant="body2" color="text.secondary">
              Generated in {data.summary_time_ms}ms
            </Typography>
          </CardContent>
        </Card>
      )}
    </Box>
  );
}

