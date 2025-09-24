import { Button } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';

export function Navigation() {
  return (
    <nav>
      <Button
        component={RouterLink}
        to="/"
        color="inherit"
        sx={{ mr: 2 }}
      >
        Search
      </Button>
      <Button
        component={RouterLink}
        to="/summary"
        color="inherit"
      >
        Summary
      </Button>
    </nav>
  );
}

