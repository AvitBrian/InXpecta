import React from 'react';
import { Doughnut } from 'react-chartjs-2';
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js';
import { schemeCategory10 } from 'd3-scale-chromatic';

ChartJS.register(ArcElement, Tooltip, Legend);

const DonutChart = ({ data }) => {
  const colorPalette = schemeCategory10;

  const chartData = {
    labels: data.map((item) => item.name),
    datasets: [
      {
        data: data.map(item => item.notoriety),
        backgroundColor: colorPalette.slice(0, data.length),
        borderWidth: 3, 
        borderColor: 'white',
      },
    ],
  };

  const chartOptions = {
    plugins: {
      legend: {
        position: 'right',
      },
      cutout: '20%', 
      tooltip: {
        callbacks: {
          label: (context) => {
            const label = context.label || '';
            const value = context.parsed || 0;
            return `${label}: ${value}%`;
          },
        },
      },
    },
    rotation: -0.5 * Math.PI, 
    animation: {
      animateRotate: true,
      animateScale: true, 
    },
    responsive: true,
    maintainAspectRatio: false,
  };

  return <Doughnut data={chartData} options={chartOptions} />;
};

export default DonutChart;
