import { useState, useEffect } from 'react';
import './index.css'

export default function ResearchApp() {
  const [works, setWorks] = useState([]);
  const [query, setQuery] = useState('');

  useEffect(() => {
    setWorks([
      {
        id: 1,
        title: 'Using Q-Methodology to Understand Environmental Opposition to Fracking',
        author: 'Ivan Petrenko',
        organization: 'Національний фонд науки',
        keyword: 'Machine Learning'
      },
      {
        id: 2,
        title: 'Effect of Land Management Practices on Soil Moisture Retention',
        author: 'Olena Havrylyuk',
        organization: 'Європейський грантовий фонд',
        keyword: 'Hydrology'
      }
    ]);
  }, []);

  const filteredWorks = works.filter(w =>
    w.title.toLowerCase().includes(query.toLowerCase()) ||
    w.author.toLowerCase().includes(query.toLowerCase()) ||
    w.keyword.toLowerCase().includes(query.toLowerCase())
  );

  return (
    <div className="min-h-screen p-6 bg-gradient-to-tr from-yellow-100 via-rose-100 to-lime-100">
      <h1 className="text-3xl font-bold text-center mb-6">📚 Research Portal</h1>
      <div className="max-w-2xl mx-auto mb-8">
        <input
          className="w-full p-2 border border-gray-300 rounded-md"
          placeholder="Search by title, author, keyword..."
          value={query}
          onChange={(e) => setQuery(e.target.value)}
        />
      </div>
      <div className="grid gap-4 max-w-4xl mx-auto">
        {filteredWorks.map(work => (
          <div key={work.id} className="bg-white rounded-xl shadow-md p-4">
            <h2 className="text-xl font-semibold mb-1">{work.title}</h2>
            <p className="text-sm">Author: <strong>{work.author}</strong></p>
            <p className="text-sm">Funded by: {work.organization}</p>
            <p className="text-sm">Keyword: #{work.keyword}</p>
          </div>
        ))}
      </div>
    </div>
  );
}