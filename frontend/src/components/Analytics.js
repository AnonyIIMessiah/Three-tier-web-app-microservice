import React, { useState, useEffect } from 'react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, Legend, ResponsiveContainer } from 'recharts';

function Analytics() {
  const [userCount, setUserCount] = useState(0);
  const [productCount, setProductCount] = useState(0);

  useEffect(() => {
    fetch('http://localhost:8080/users')
      .then(response => response.json())
      .then(data => setUserCount(data.length));

    fetch('http://localhost:8080/products')
      .then(response => response.json())
      .then(data => setProductCount(data.length));
  }, []);

  const data = [
    { name: 'Users', count: userCount },
    { name: 'Products', count: productCount },
  ];

  return (
    <div>
      <h2>Analytics</h2>
      <ResponsiveContainer width="100%" height={300}>
        <BarChart data={data}>
          <XAxis dataKey="name" />
          <YAxis />
          <Tooltip />
          <Legend />
          <Bar dataKey="count" fill="#8884d8" />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
}

export default Analytics;

