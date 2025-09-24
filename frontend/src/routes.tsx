import { Routes, Route } from 'react-router-dom';
import { SearchPage } from './pages/SearchPage';
import { SummaryPage } from './pages/SummaryPage';
import { NotFoundPage } from './pages/NotFoundPage';

export function AppRoutes() {
  return (
    <Routes>
      <Route path="/" element={<SearchPage />} />
      <Route path="/summary" element={<SummaryPage />} />
      <Route path="*" element={<NotFoundPage />} />
    </Routes>
  );
}

