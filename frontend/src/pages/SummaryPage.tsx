import { useState } from 'react';
import { useMutation } from '@tanstack/react-query';
import {
  Box,
  Card,
  CardContent,
  TextField,
  Button,
  Typography,
  CircularProgress,
  Alert,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
} from '@mui/material';
import { documentService } from '../api/services';
import { DocumentSummaryRequest, DocumentSummaryResponse } from '../api/types';

const AI_MODELS = [
  {
    value: "gpt-3.5-turbo-16k",
    label: "GPT-3.5 Turbo (16k)",
  },
  {
    value: "gpt-4-turbo-preview",
    label: "GPT-4 Turbo",
  },
  {
    value: "claude-3-sonnet",
    label: "Claude 3 Sonnet",
  },
  {
    value: "claude-3-opus",
    label: "Claude 3 Opus",
  },
] as const;

export function SummaryPage() {
  const [documentIds, setDocumentIds] = useState<string>('');
  const [model, setModel] = useState<string>(AI_MODELS[0].value);

  const [summaryResult, setSummaryResult] = useState<DocumentSummaryResponse | null>(null);

  const { mutate, isLoading, error } = useMutation({
    mutationFn: documentService.generateSummary,
    onSuccess: (data) => {
      setSummaryResult(data);
    },
  });

  const isValidInput = () => {
    const ids = documentIds.split(',').map(id => id.trim()).filter(id => id);
    return ids.length > 0 && model.trim();
  };

  const handleGenerateSummary = () => {
    if (isValidInput()) {
      mutate({
        ids: documentIds.split(',').map((id) => id.trim()),
        model,
      } as DocumentSummaryRequest);
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
          <FormControl fullWidth sx={{ mb: 2 }}>
            <InputLabel id="ai-model-label">AI Model</InputLabel>
            <Select
              labelId="ai-model-label"
              value={model}
              label="AI Model"
              onChange={(e) => setModel(e.target.value)}
            >
              {AI_MODELS.map((model) => (
                <MenuItem key={model.value} value={model.value}>
                  {model.label}
                </MenuItem>
              ))}
            </Select>
          </FormControl>
          <Button
            variant="contained"
            onClick={handleGenerateSummary}
            disabled={isLoading || !isValidInput()}
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

      {summaryResult && (
        <Card>
          <CardContent>
            <Typography variant="h6" gutterBottom>
              Summary
            </Typography>
            <Typography variant="body1" paragraph>
              {summaryResult.summary_text}
            </Typography>
            <Typography variant="body2" color="text.secondary">
              Generated in {summaryResult.summary_time_ms}ms
            </Typography>
          </CardContent>
        </Card>
      )}
    </Box>
  );
}

