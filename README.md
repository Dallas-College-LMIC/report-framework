# Report Framework

A Python-based data analysis framework for labor market research and reporting, designed for educational institutions and workforce development organizations. Built specifically for Dallas College LMIC (Labor Market Information Center) to streamline the process of analyzing stakeholder requests and generating comprehensive labor market reports.

## Features

- **Automated Data Specification Generation**: Convert stakeholder requests into structured data collection specifications
- **Multi-Source Integration**: Seamlessly connect to Lightcast API, Census data, and institutional data sources
- **Standardized Workflow**: From request intake to final deliverable with consistent quality and format
- **Custom Claude Code Commands**: Intelligent analysis tools integrated into the development environment
- **Quality Assurance**: Built-in validation, formatting, and review processes

## Quick Start

### Prerequisites

- [Nix](https://nixos.org/download.html) with flakes enabled
- Lightcast API credentials (set as `LCAPI_USER` and `LCAPI_PASS` environment variables in a .env)
- [direnv](https://direnv.net/)

## Usage

### Creating Data Specifications

Use the custom Claude Code command to analyze stakeholder requests and generate data specifications:

```
/rf-create-report-spec path/to/request.pdf
```

This command will:
1. Parse the stakeholder request document
2. Identify and explore relevant data sources
3. Generate a comprehensive data specification
4. Create a structured project folder in `reports/`

### Generating Reports from Specifications

Once you have a data specification, use the automated report generation command:

```
/rf-generate-report path/to/data_spec.md [--dry-run]
```

This command will:
1. Parse the data specification file
2. Automatically detect required data sources (Lightcast API, Census data)
3. Generate a purpose-built Python script with proper error handling
4. Execute the script to collect data and produce professional Excel reports
5. Export CSV files for data verification and debugging

**Parameters:**
- `data_spec.md`: Path to the data specification markdown file
- `--dry-run`: Optional flag to generate the script without executing it

### Example Workflow

1. **Receive Request**: Place stakeholder request document in the project
2. **Generate Specification**: Run `/rf-create-report-spec REQUEST.pdf`
3. **Review Output**: Check generated specification in `reports/YYYY-MM-DD_requestor_topic/`
4. **Generate Report**: Run `/rf-generate-report reports/YYYY-MM-DD_requestor_topic/data_spec.md`
5. **Quality Check**: Review generated Excel and CSV files for accuracy
6. **Deliver**: Provide the professional Excel report to stakeholders

## Dependencies

### Core Libraries
- **[pyghtcast](https://github.com/Dallas-College-LMIC/pyghtcast)**: Python client for Lightcast APIs
- **[censusdis-cli](https://github.com/Dallas-College-LMIC/censusdis-cli)**: Command-line interface for Census data discovery
- **[dclmic-export](https://github.com/Dallas-College-LMIC/dclmic-export)**: Dallas College LMIC data export utilities
- **pandas**: Data manipulation and analysis

### Data Sources
- **Lightcast API** (formerly EMSI): Labor market data, occupations, industries, wages, projections
- **U.S. Census Bureau**: Demographic and economic data via American Community Survey

## Environment Variables

Set up your environment variables in a `.env` file (see `.env.example`):

```bash
LCAPI_USER=your_lightcast_username
LCAPI_PASS=your_lightcast_password
```
