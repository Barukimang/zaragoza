import React from 'react';
import styled from 'styled-components';
import {withTransaction} from '@elastic/apm-rum-react';
import {useParams} from 'react-router-dom';

import {useProposal} from '../hooks/useProposal';

const Proposal: React.FC = () => {
  const {id} = useParams();
  const {data: proposalData} = useProposal(id || '2');

  return (
    // TODO: assemble proposal overview page here. Mock data can be obtained by
    // the useProposal hook.
    <Content>
      <Header>Proposal {id}</Header>
      <p>This page contains the overview for proposal {id}</p>
      <p>{JSON.stringify(proposalData, null, 2)}</p>
    </Content>
  );
};

export default withTransaction('Proposal', 'component')(Proposal);

const Content = styled.div.attrs({className: 'tablet:w-2/3 m-auto'})``;
const Header = styled.p.attrs({className: 'text-bold text-xl'})``;
